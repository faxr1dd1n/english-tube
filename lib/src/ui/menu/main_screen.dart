import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/home/home_screen.dart';
import 'package:en_tube/src/ui/menu/learn/learn_screen.dart';
import 'package:en_tube/src/ui/menu/progress/progress_screen.dart';
import 'package:en_tube/src/ui/menu/tutors/mentors_screen.dart';
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
    MentorsScreen(),
    LearnScreen(),
    ProgressScreen(),
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
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.geeralColor,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            unselectedItemColor: AppColor.white.withOpacity(0.5),
            selectedItemColor: AppColor.white,
            selectedIconTheme: const IconThemeData(color: AppColor.white),
            unselectedIconTheme: IconThemeData(color: AppColor.white.withOpacity(0.5)),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.ondemand_video_rounded),
                label: 'Mentors'),

              BottomNavigationBarItem(icon: Icon(Icons.menu_book_sharp), label: 'Learn'),
              BottomNavigationBarItem(icon: Icon(Icons.line_axis_rounded), label: 'Progress'),

              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
