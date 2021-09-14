import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class MockService {
  List<RecipeModel> _recipes1 = [];
  List<RecipeModel> _recipes2 = [];
  Random nextRecipe = Random();

  void create() async {
    loadRecipes();
  }

  void loadRecipes() async {
    var jsonString = await rootBundle.loadString('assets/recipes1.json');
    _recipes1 = RecipeModel.fromJsonString(jsonString);
    jsonString = await rootBundle.loadString('assets/recipes2.json');
    _recipes2 = RecipeModel.fromJsonString(jsonString);
    print("loadRecipes recipes1.length: ${_recipes1.length} | recipes2.length: ${_recipes2.length}");
  }

  Future<Response?> getMockDatas() {
    switch (nextRecipe.nextInt(2)) {
      case 0:
        return Future.value(Response(data: _recipes1, requestOptions: RequestOptions(path: "path")));
      case 1:
        return Future.value(Response(data: _recipes2, requestOptions: RequestOptions(path: "path")));
      default:
        return Future.value(Response(data: _recipes1, requestOptions: RequestOptions(path: "path")));
    }
  }

  static Future<Response?> getMockDatasx() async {
    String jsonString = await rootBundle.loadString('assets/recipes1.json');
    Map<String, dynamic> maps = jsonDecode(jsonString);
    return Future.value(Response(data: maps, requestOptions: RequestOptions(path: "path")));
  }
}
