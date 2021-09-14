import 'package:flutter/material.dart';
import 'package:kmmi_food_app/data/commons/memory_repository.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.recipeModel}) : super(key: key);
  final RecipeModel recipeModel;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<MemoryRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeModel.recipe.label),
      ),
      body: null,
    );
  }
}
