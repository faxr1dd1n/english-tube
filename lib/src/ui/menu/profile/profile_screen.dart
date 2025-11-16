import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("user_name") ?? "User";
      userEmail = prefs.getString("user_email") ?? "No email";
    });
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("user_email");
    await prefs.remove("user_name");
    await prefs.remove("user_password");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),

        title: const Text("Profile", style: TextStyle(color: AppColor.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColor.white),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              backgroundImage: const NetworkImage(
                "https://thumbs.dreamstime.com/b/d-icon-avatar-student-man-reading-book-school-concept-education-learning-isolated-transparent-png-background-cartoon-352289965.jpg",
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userEmail,
              style: const TextStyle(
                color: AppColor.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
