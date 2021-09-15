import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/data/repository/memory_repository.dart';
import 'package:provider/provider.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({Key? key, required this.recipeModel}) : super(key: key);
  final RecipeModel recipeModel;

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    final MemoryRepository repository = Provider.of<MemoryRepository>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.network(
                        widget.recipeModel.recipe.image,
                        alignment: Alignment.topLeft,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                        child: const BackButton(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    widget.recipeModel.recipe.label,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Chip(
                      label: Text(widget.recipeModel.recipe.getCaloriesInfo()),
                    )),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    ),
                    onPressed: () {
                      repository.addFavoriteRecipe(widget.recipeModel);
                      repository.addGroceries(widget.recipeModel.recipe.ingredientLines);
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icon_bookmark.svg',
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Favourite',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
