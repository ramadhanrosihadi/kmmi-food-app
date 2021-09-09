import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kmmi_food_app/api/api_provider.dart';
import 'package:kmmi_food_app/data/Recipe.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Recipe recipe = Recipe();
  String keyword = "chicken";
  String text = "";
  List<RecipeModel> recipeModels = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
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
      var responseJson = jsonDecode(jsonEncode(response.data.toString()));
      List<RecipeModel> results = RecipeModel.fromListDynamic(jsonDecode(responseJson['hits']));
      setState(() {
        recipeModels = results;
      });
      print("recipeModels.length : ${results.length}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(),
      ),
      body: Container(
        width: double.infinity,
        child: GestureDetector(
          onTap: getData,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Response API : '),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
