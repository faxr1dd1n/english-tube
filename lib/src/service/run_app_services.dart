import 'package:shared_preferences/shared_preferences.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';

class RunAppServices {
  static Future<void> saveIsFirstOpenApp(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirst", value);
  }

  static Future<bool> getIsFirstOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isFirst") ?? false;
  }

  // User name ni saqlash
  static Future<void> saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", userName);
  }

  // User name ni o'qish
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_name");
  }

  // User name ni yangilash (app ochilishida)
  static Future<void> loadAndSaveUserName() async {
    try {
      final user = authService.value.currentUser;
      if (user != null) {
        await user.reload();
        final displayName = user.displayName ?? "User";
        await saveUserName(displayName);
      }
    } catch (e) {
      print("Error loading user name: $e");
    }
  }
}
