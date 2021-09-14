import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kmmi_food_app/api/api_provider.dart';
import 'package:kmmi_food_app/data/Recipe.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/detail_page.dart';
import 'package:kmmi_food_app/search_page.dart';
import 'package:kmmi_food_app/shared_preferences/app_pref.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Recipe recipe = Recipe();
  String keyword = "chicken";
  List<RecipeModel> recipeModels = [];
  TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;
  var recipes = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() => isLoading = true);
    Response response = await ApiProvider.callApi(
      "https://api.edamam.com/api/recipes/v2",
      {
        "app_id": "74685d72",
        "app_key": "a0b78e3d14929f4c2ea1b8e5c26ed312",
        "type": "public",
        "q": keyword,
      },
    );
    if (response.data != null) {
      var jsonResponse = jsonDecode(jsonEncode(response.data));
      var newRecipes = jsonResponse['hits'];
      List<RecipeModel> newRecipeModels = RecipeModel.fromListDynamic(jsonResponse['hits']);
      setState(() {
        recipes = newRecipes;
        recipeModels = newRecipeModels;
      });
      print("recipeModels.length : ${newRecipeModels.length}");
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () async {
            String result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
            if (result != null) {
              setState(() {
                keyword = result;
                textEditingController.text = keyword;
              });
              getData();
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Cari disini...",
              ),
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return Center(
              child: Text('Mohon tunggu..'),
            );
          } else if (recipeModels.isEmpty) {
            return Center(child: Text('Pencarian tidak ditemukan'));
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              itemBuilder: (context, index) {
                RecipeModel data = recipeModels[index];
                var recipe = recipes[index]['recipe'];
                return GestureDetector(
                  onTap: () async {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(recipeModel: data)()));
                  },
                  child: Row(
                    children: [
                      Image.network(
                        recipe['image'] ?? "-",
                        height: 50,
                        width: 50,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Icon(Icons.not_accessible, size: 50);
                        },
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(recipe['label']),
                          subtitle: Text("${recipe['totalTime']} minutes"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: recipeModels.length,
            ),
          );
        },
      ),
    );
  }
}
