import 'package:kmmi_food_app/data/recipe.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';

abstract class Repository {
  Future init();
  void close();
  List<Recipe> getAllRecipes();
  Recipe getRecipeByUri(String uri);
  void insertRecipe(Recipe recipe);
  void deleteRecipe(Recipe recipe);
  List<String> getAllIngredients();
  void insertIngredients(List<String> values);
  void deleteIngredients(String value);
}
