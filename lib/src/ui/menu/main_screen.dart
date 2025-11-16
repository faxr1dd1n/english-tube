import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/home/home_screen.dart';
import 'package:en_tube/src/ui/menu/lessons/lessons_screen.dart';
import 'package:en_tube/src/ui/menu/profile/profile_screen.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    LessonsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppColor.geeralColor,

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: AppColor.white.withOpacity(0.5),
        selectedItemColor:  AppColor.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Lessons'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
