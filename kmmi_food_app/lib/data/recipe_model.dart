import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kmmi_food_app/api/api_provider.dart';

import 'links.dart';
import 'recipe.dart';

class RecipeModel extends Equatable {
  final Recipe recipe;
  final Links links;
  RecipeModel({
    required this.recipe,
    required this.links,
  });

  Map<String, dynamic> toMap() {
    return {
      'recipe': recipe.toMap(),
      'links': links.toMap(),
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      recipe: Recipe.fromMap(map['recipe']),
      links: Links.fromMap(map['_links']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromJson(String source) => RecipeModel.fromMap(json.decode(source));

  static List<RecipeModel> fromListDynamic(List<dynamic> datas) {
    if (datas == null) return [];
    return datas.map<RecipeModel>((e) => RecipeModel.fromMap(e)).toList();
  }

  @override
  List<Object?> get props => [recipe, links];

  static Future<Response?> searchFromApi(String keyword) async {
    Response response = await ApiProvider.callApi(
      "https://api.edamam.com/api/recipes/v2",
      {
        "app_id": "74685d72",
        "app_key": "a0b78e3d14929f4c2ea1b8e5c26ed312",
        "type": "public",
        "q": keyword,
      },
    );
    return response;
  }

  static List<RecipeModel> fromResponse(Response? response) {
    try {
      if (response!.data != null) {
        var jsonResponse = jsonDecode(jsonEncode(response.data));
        List<RecipeModel> newRecipeModels = RecipeModel.fromListDynamic(jsonResponse['hits']);
        return newRecipeModels;
      }
    } catch (e) {}
    return [];
  }
}
