import 'package:flutter/material.dart';
import 'package:kmmi_food_app/data/repository/memory_repository.dart';
import 'package:provider/provider.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoryRepository>(builder: (context, repository, child) {
      List<String> groceries = repository.getAllGrocery();
      return ListView.builder(
          itemCount: groceries.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value: false,
              title: Text(groceries[index]),
              onChanged: (newValue) {},
            );
          });
    });
  }
}
