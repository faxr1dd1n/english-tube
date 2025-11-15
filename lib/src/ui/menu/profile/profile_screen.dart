import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,

      appBar: AppBar(
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        title: const Text('Profile', style: TextStyle(color: AppColor.white)),
      ),
      body: Center(
        child: Text('Profile Screen', style: TextStyle(color: AppColor.white)),
      ),
    );
  }
}
