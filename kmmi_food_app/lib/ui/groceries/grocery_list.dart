import 'package:flutter/material.dart';
import 'package:kmmi_food_app/data/repository/memory_repository.dart';
import 'package:kmmi_food_app/data/repository/repository.dart';
import 'package:provider/provider.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  _GroceryListState createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    return StreamBuilder<List<String>>(
      stream: repository.watchAllGrocery(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final List<String> groceries = snapshot.data ?? [];
          return ListView.builder(
              itemCount: groceries.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: false,
                  title: Text(groceries[index]),
                  onChanged: (newValue) {},
                );
              });
        }
        return SizedBox();
      },
    );
  }
}
