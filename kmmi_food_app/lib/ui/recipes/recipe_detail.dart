import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kmmi_food_app/data/custom_timer.dart';
import 'package:kmmi_food_app/data/recipe_model.dart';
import 'package:kmmi_food_app/data/repository/memory_repository.dart';
import 'package:kmmi_food_app/data/repository/repository.dart';
import 'package:provider/provider.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({Key? key, required this.recipeModel}) : super(key: key);
  final RecipeModel recipeModel;

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    log("getData");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> datas = firestore.collection('tests');
    QuerySnapshot<Map<String, dynamic>> results = await datas.get();
    for (DocumentSnapshot<Map<String, dynamic>> ds in results.docs) {
      Map<String, dynamic>? map = ds.data();
      if (map != null) {
        log("getData documentSnapshot data1 : ${map['data1']}");
      }
      log("getData documentSnapshot id : ${ds.id}");
      log("getData documentSnapshot ds.data : ${ds.data()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Repository repository = Provider.of<Repository>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: getData,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Image.network(
                                widget.recipeModel.recipe.image,
                                alignment: Alignment.topLeft,
                                fit: BoxFit.fill,
                                width: double.infinity,
                              ),
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
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Text(
                              widget.recipeModel.recipe.label,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance.collection("tests").doc("IHAOa6C1FUA0qt9y62r4").snapshots(),
                              builder: (context, snapshot) {
                                String spicyLevel = "Not Spicy";
                                if (snapshot.hasData) {
                                  Map<String, dynamic> map = snapshot.data!.data()!;
                                  spicyLevel = map['spicyLevel'];
                                }
                                return Text("($spicyLevel)", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red));
                              },
                            ),
                          ],
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
            Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder(
                stream: CustomTimer().stream,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return Text("How long you've been here : ${snapshot.data} seconds");
                  }
                  return Text("How long you've been here : 0 seconds");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
