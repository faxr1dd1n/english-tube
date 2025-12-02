import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/constraints/app_icons.dart';
import 'package:en_tube/src/ui/menu/home/home_screen.dart';
import 'package:en_tube/src/ui/menu/learn/learn_screen.dart';
import 'package:en_tube/src/ui/menu/progress/progress_screen.dart';
import 'package:en_tube/src/ui/menu/mentors/mentors_screen.dart';
import 'package:en_tube/src/ui/menu/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            unselectedIconTheme: IconThemeData(
              color: AppColor.white.withOpacity(0.5),
            ),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.homeMenu,
                  color: _selectedIndex == 0
                      ? AppColor.white
                      : AppColor.white.withOpacity(0.5),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 26,
                  child: SvgPicture.asset(
                    AppIcons.mentorMenu,
                    color: _selectedIndex == 1
                        ? AppColor.white
                        : AppColor.white.withOpacity(0.5),
                        height:28,
                  ),
                ),
                label: 'Mentors',
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.learnMenu,
                  color: _selectedIndex == 2
                      ? AppColor.white
                      : AppColor.white.withOpacity(0.5),
                ),
                label: 'Learn',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.chartMenu,
                  color: _selectedIndex == 3
                      ? AppColor.white
                      : AppColor.white.withOpacity(0.5),
                ),
                label: 'Progress',
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.profileMenu,
                  color: _selectedIndex == 4
                      ? AppColor.white
                      : AppColor.white.withOpacity(0.5),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
