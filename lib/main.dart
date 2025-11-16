import 'package:en_tube/src/ui/login/login_screen.dart';
import 'package:en_tube/src/ui/menu/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
String token = '';
bool get isLogged => token.isNotEmpty;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // iOS/MacOS uchun kechikish qo‘shiladi
  await Future.delayed(const Duration(milliseconds: 100));

  final prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token") ?? '';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogged ? const MainScreen() : const LoginScreen(),
    );
  }
}
