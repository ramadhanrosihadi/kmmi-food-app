import 'package:kmmi_food_app/data/recipe.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';

abstract class Repository {
  Future init();
  void close();

  List<RecipeModel> getFavouriteRecipes();
  RecipeModel findFavoriteRecipeByUri(String uri);
  void addFavoriteRecipe(RecipeModel recipe);
  void deleteFavoriteRecipe(RecipeModel recipe);

  List<String> getAllGrocery();
  void addGroceries(List<String> values);
  void deleteGrocery(String value);
}
