import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),

        title: const Text('Home',style: TextStyle(color: AppColor.white,),),
      ),
      body: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(color: AppColor.white),
        ),
      ),
    );
  }
}
