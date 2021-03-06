import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kmmi_food_app/data/recipe.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/data/repository/memory_repository.dart';
import 'package:provider/provider.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({Key? key}) : super(key: key);

  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryRepository>(builder: (context, repository, child) {
      List<RecipeModel> recipeModels = repository.getFavouriteRecipes();
      return ListView.builder(
          itemCount: recipeModels.length,
          itemBuilder: (BuildContext context, int index) {
            final Recipe recipe = recipeModels[index].recipe;
            return SizedBox(
              height: 100,
              child: Slidable(
                actionPane: const SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CachedNetworkImage(imageUrl: recipe.image, height: 120, width: 60, fit: BoxFit.cover),
                        title: Text(recipe.label),
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.transparent,
                    foregroundColor: Colors.black,
                    iconWidget: const Icon(Icons.delete, color: Colors.red),
                    onTap: () => repository.deleteFavoriteRecipe(recipeModels[index]),
                  ),
                ],
              ),
            );
          });
    });
  }
}
