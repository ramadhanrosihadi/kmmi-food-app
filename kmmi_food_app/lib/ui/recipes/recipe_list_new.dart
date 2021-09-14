import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kmmi_food_app/api/api_provider.dart';
import 'package:kmmi_food_app/data/mock_service/mock_service.dart';
import 'package:kmmi_food_app/data/recipe.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/ui/recipes/recipe_detail.dart';
import 'package:kmmi_food_app/ui/recipes/search_page.dart';
import 'package:provider/provider.dart';

class RecipeListNew extends StatefulWidget {
  const RecipeListNew({Key? key}) : super(key: key);

  @override
  _RecipeListNewState createState() => _RecipeListNewState();
}

class _RecipeListNewState extends State<RecipeListNew> {
  List<RecipeModel> recipeModels = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchPage() async {
    String? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
    if (result != null) {
      setState(() {
        textEditingController.text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: navigateToSearchPage,
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
      body: FutureBuilder<Response?>(
        future: MockService.getMockDatasx(),
        // future: RecipeModel.searchFromApi(textEditingController.text),
        builder: (context, response) {
          if (response.connectionState == ConnectionState.done) {
            if (response.hasError) {
              return Center(child: Text(response.error.toString(), textAlign: TextAlign.center, textScaleFactor: 1.3));
            }
            recipeModels = RecipeModel.fromResponse(response.data);
            print("recipe_list_new recipeModels.length: ${recipeModels.length}");
            if (recipeModels.isEmpty) {
              if (textEditingController.text != "") return Center(child: Text('Pencarian dengan kata kunci ${textEditingController.text} tidak ditemukan'));
              return Center(
                child: ElevatedButton.icon(
                  label: Icon(Icons.search, size: 16),
                  icon: Text('Search for recipes'),
                  onPressed: navigateToSearchPage,
                ),
              );
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  Recipe data = recipeModels[index].recipe;
                  return GestureDetector(
                    onTap: () async {
                      Response? response = await Provider.of<MockService>(context, listen: false).getMockDatas();

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetail(recipe: data)));
                    },
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: data.image,
                          height: 50,
                          width: 50,
                          errorWidget: (context, url, _) {
                            return Icon(Icons.not_accessible, size: 50);
                          },
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(data.label),
                            subtitle: Text("${data.totalTime} minutes"),
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
          }
          return Center(child: Text('Mohon tunggu..'));
        },
      ),
    );
  }
}
