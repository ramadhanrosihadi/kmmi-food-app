import 'package:flutter/cupertino.dart';
import 'package:kmmi_food_app/data/commons/repository.dart';
import 'package:kmmi_food_app/data/recipe.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<String> _currentIngredients = [];
  @override
  void close() {}

  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    notifyListeners();
  }

  @override
  List<Recipe> getAllRecipes() {
    return _currentRecipes;
  }

  @override
  Recipe getRecipeByUri(String uri) {
    return _currentRecipes.firstWhere((element) => element.uri == uri);
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    notifyListeners();
  }

  @override
  void deleteIngredients(String value) {
    _currentIngredients.remove(value);
  }

  @override
  void insertIngredients(List<String> values) {
    _currentIngredients.addAll(values);
  }

  @override
  List<String> getAllIngredients() {
    return _currentIngredients;
  }
}
