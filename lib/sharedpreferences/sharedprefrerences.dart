import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  static final Prefs prefs = Prefs._();

  String language;

  Future<bool> setLanguage(String language) async {
    SharedPreferences sharePreferences = await SharedPreferences.getInstance();

    return sharePreferences.setString("key_language", language);
  }

  Future<String> getLanguage() async {
    return (await SharedPreferences.getInstance()).getString("key_language") ??
        "id";
  }
}
