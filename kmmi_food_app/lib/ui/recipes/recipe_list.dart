import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kmmi_food_app/api/api_provider.dart';
import 'package:kmmi_food_app/data/recipe.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/data/repository/memory_repository.dart';
import 'package:kmmi_food_app/ui/recipes/recipe_detail.dart';
import 'package:kmmi_food_app/ui/recipes/search_page.dart';
import 'package:provider/provider.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  TextEditingController textEditingController = TextEditingController(text: "chicken");
  StreamController streamController = StreamController();
  late Stream<int> stream;
  int second = 0;

  @override
  void initState() {
    super.initState();
    runTimer();
  }

  void navigateToSearchPage() async {
    String? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
    if (result != null) {
      setState(() {
        textEditingController.text = result;
      });
    }
  }

  void runTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {});
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "$second seconds",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: FutureBuilder<Response?>(
              future: RecipeModel.searchFromApi(textEditingController.text),
              builder: (context, response) {
                if (response.connectionState == ConnectionState.done) {
                  if (response.hasError) {
                    return Center(child: Text(response.error.toString()));
                  }
                  List<RecipeModel> recipeModels = RecipeModel.fromResponse(response.data);
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetail(recipeModel: recipeModels[index])));
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
          ),
        ],
      ),
    );
  }
}
