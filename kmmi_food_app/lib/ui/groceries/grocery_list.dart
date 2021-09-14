import 'package:flutter/material.dart';
import 'package:kmmi_food_app/data/commons/memory_repository.dart';
import 'package:provider/provider.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<String> ingredients = <String>[];

  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryRepository>(builder: (context, repository, child) {
      ingredients = repository.getAllIngredients();
      return ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value: false,
              title: Text(ingredients[index]),
              onChanged: (newValue) {},
            );
          });
    });
  }
}
