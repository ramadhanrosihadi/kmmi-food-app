import 'package:flutter/material.dart';
import 'package:kmmi_food_app/shared_preferences/app_pref.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> suggestions = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    List<String> keywords = await AppPref.loadSearchKeyword();
    setState(() => suggestions = keywords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[800], size: 20),
        backgroundColor: Colors.white,
        title: TextField(
          autofocus: true,
          controller: textEditingController,
          onSubmitted: (value) async {
            await AppPref.saveSearchKeyword(value);
            Navigator.of(context).pop(value);
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(hintText: "Cari disini"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  textEditingController.text = suggestions[index];
                });
                Navigator.of(context).pop(suggestions[index]);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(suggestions[index]),
                  SizedBox(height: 15),
                ],
              ),
            );
          },
          itemCount: suggestions.length,
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
