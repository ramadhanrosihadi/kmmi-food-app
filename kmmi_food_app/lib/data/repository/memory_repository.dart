import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/data/repository/repository.dart';

class MemoryRepository extends Repository {
  List<RecipeModel> _favoriteRecipes = [];
  List<String> _groceries = [];

  Stream<List<RecipeModel>>? _favoriteRecipeStream;
  Stream<List<String>>? _groceryStream;
  final StreamController<List<RecipeModel>> _favoriteRecipeStreamController = StreamController<List<RecipeModel>>();
  final StreamController<List<String>> _groceryStreamController = StreamController<List<String>>();

  @override
  void addFavoriteRecipe(RecipeModel recipe) {
    _favoriteRecipes.add(recipe);
    _favoriteRecipeStreamController.sink.add(_favoriteRecipes);

    _groceries.addAll(recipe.recipe.ingredientLines);
    _groceryStreamController.sink.add(_groceries);
  }

  @override
  void addGroceries(List<String> values) {
    _groceries.addAll(values);
  }

  @override
  void deleteFavoriteRecipe(RecipeModel recipe) {
    _favoriteRecipes.remove(recipe);
  }

  @override
  void deleteGrocery(String value) {
    _groceries.remove(value);
  }

  @override
  RecipeModel findFavoriteRecipeByUri(String uri) {
    return _favoriteRecipes.firstWhere((element) => element.recipe.uri == uri);
  }

  @override
  Future<List<String>> getAllGrocery() {
    return Future.value(_groceries);
  }

  @override
  Future<List<RecipeModel>> getFavouriteRecipes() {
    return Future.value(_favoriteRecipes);
  }

  @override
  void close() {}

  @override
  Future init() async {
    return Future.value(null);
  }

  @override
  Stream<List<String>>? watchAllGrocery() {
    if (_groceryStream == null) {
      _groceryStream = _groceryStreamController.stream;
    }
    return _groceryStream;
  }

  @override
  Stream<List<RecipeModel>>? watchFavouriteRecipes() {
    if (_favoriteRecipeStream == null) {
      _favoriteRecipeStream = _favoriteRecipeStreamController.stream;
    }
    return _favoriteRecipeStream;
  }
}
