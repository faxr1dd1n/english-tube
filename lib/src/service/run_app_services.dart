import 'package:shared_preferences/shared_preferences.dart';

class RunAppServices {
  static Future<void> saveIsFirstOpenApp(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirst", value);
  }

  static Future<bool> getIsFirstOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isFirst") ?? false;
  }
}
