import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static saveSearchKeyword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> existingKeywords = prefs.getStringList('keywords') ?? [];
    existingKeywords.add(value);
    prefs.setStringList('keywords', existingKeywords);
  }

  static loadSearchKeyword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('keywords') ?? [];
  }
}
