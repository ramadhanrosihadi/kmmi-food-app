import 'package:flutter/cupertino.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/data/repository/repository.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  List<RecipeModel> _favoriteRecipes = [];
  List<String> _groceries = [];

  @override
  void addFavoriteRecipe(RecipeModel recipe) {
    _favoriteRecipes.add(recipe);
    notifyListeners();
  }

  @override
  void addGroceries(List<String> values) {
    _groceries.addAll(values);
    notifyListeners();
  }

  @override
  void deleteFavoriteRecipe(RecipeModel recipe) {
    _favoriteRecipes.remove(recipe);
    notifyListeners();
  }

  @override
  void deleteGrocery(String value) {
    _groceries.remove(value);
    notifyListeners();
  }

  @override
  RecipeModel findFavoriteRecipeByUri(String uri) {
    return _favoriteRecipes.firstWhere((element) => element.recipe.uri == uri);
  }

  @override
  List<String> getAllGrocery() {
    return _groceries;
  }

  @override
  List<RecipeModel> getFavouriteRecipes() {
    return _favoriteRecipes;
  }

  @override
  void close() {}

  @override
  Future init() async {
    return Future.value(null);
  }
}
