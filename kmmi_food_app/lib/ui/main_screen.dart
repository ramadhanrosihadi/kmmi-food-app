import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kmmi_food_app/ui/favourites/favourite_list.dart';
import 'package:kmmi_food_app/ui/recipes/recipe_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'groceries/grocery_list.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[];
  static const String prefSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pageList.add(const RecipeList());
    pageList.add(const FavouriteList());
    pageList.add(const GroceryList());
    getCurrentIndex();
  }

  void saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(prefSelectedIndexKey, _selectedIndex);
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        _selectedIndex = prefs.getInt(prefSelectedIndexKey) ?? 0;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    saveCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    String title = "";
    switch (_selectedIndex) {
      case 0:
        title = 'Recipes';
        break;
      case 1:
        title = 'Favourites';
        break;
      case 2:
        title = 'Groceries';
        break;
    }
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/icon_recipe.svg', color: _selectedIndex == 0 ? Colors.green : Colors.grey, semanticsLabel: 'Recipes'), label: 'Recipes'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/icon_bookmarks.svg', color: _selectedIndex == 1 ? Colors.green : Colors.grey, semanticsLabel: 'Bookmarks'), label: 'Bookmarks'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/icon_shopping_list.svg', color: _selectedIndex == 2 ? Colors.green : Colors.grey, semanticsLabel: 'Groceries'), label: 'Groceries'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pageList,
      ),
    );
  }
}
