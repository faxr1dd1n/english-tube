import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/bloc/mentor/mentor_bloc.dart';
import 'package:en_tube/src/constraints/app_icons.dart';
import 'package:en_tube/src/widgets/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.home: GlobalKey<NavigatorState>(),
    NavItemEnum.category: GlobalKey<NavigatorState>(),
    NavItemEnum.basket: GlobalKey<NavigatorState>(),
    NavItemEnum.favorite: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
  };
  late final TabController _tabController;
  int _selectedIndex = 0;
  DateTime? _lastBackPressed;

  Widget _buildPageNavigator(NavItemEnum tabItem) =>
      TabNavigator(navigatorKey: _navigatorKeys[tabItem]!, tabItem: tabItem);
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 5, vsync: this, animationDuration: Duration.zero)
          ..addListener(() {
            setState(() {
              _selectedIndex = _tabController.index;
            });
          });
  }
void showExitToast() {
  Fluttertoast.cancel(); // 🔴 oldingisini yopadi
  Fluttertoast.showToast(
    msg: "common.press_again_to_exit".tr(),
    toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(200, 0, 0, 0),
        textColor: Colors.white,
        fontSize: 12,
  );
}
@override
void dispose() {
  _tabController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return HomeTabControllerProvider(
      controller: _tabController,
      child: BlocProvider(
        create: (context) => MentorBloc()..add(GetMentorsEvent()),
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;

            final currentTab = NavItemEnum.values[_selectedIndex];
            final navigatorKey = _navigatorKeys[currentTab];
            final navigatorState = navigatorKey?.currentState;
            if (navigatorState != null && navigatorState.canPop()) {
              navigatorState.pop();
              return;
            }

            // Agar home tabda bo'lmasa, avval home tabga o'tadi
            if (_selectedIndex != 0) {
              _tabController.animateTo(0);
              _lastBackPressed = null; // Reset qilish
              return;
            }

            // Home tabda: 2 marta back bosish logikasi
            final now = DateTime.now();
            if (_lastBackPressed == null ||
                now.difference(_lastBackPressed!) >
                    const Duration(seconds: 2)) {
              _lastBackPressed = now;
              showExitToast();
              return;
            }
            SystemNavigator.pop();
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                _buildPageNavigator(NavItemEnum.home),
                _buildPageNavigator(NavItemEnum.category),
                _buildPageNavigator(NavItemEnum.basket),
                _buildPageNavigator(NavItemEnum.favorite),
                _buildPageNavigator(NavItemEnum.profile),
              ],
            ),
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
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  currentIndex: _selectedIndex,
                  onTap: (value) {
                    _tabController.animateTo(value);
                  },
                  unselectedItemColor: Colors.white.withOpacity(0.5),
                  selectedItemColor: Colors.white,
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  unselectedIconTheme: IconThemeData(
                    color: Colors.white.withOpacity(0.5),
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
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: 'navigation.home'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox(
                        height: 26,
                        child: SvgPicture.asset(
                          AppIcons.mentorMenu,
                          color: _selectedIndex == 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          height: 28,
                        ),
                      ),
                      label: 'navigation.mentors'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.learnMenu,
                        color: _selectedIndex == 2
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: 'navigation.learn'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.chartMenu,
                        color: _selectedIndex == 3
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: 'navigation.progress'.tr(),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.profileMenu,
                        color: _selectedIndex == 4
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: 'navigation.profile'.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTabControllerProvider extends InheritedWidget {
  final TabController controller;

  const HomeTabControllerProvider({
    super.key,
    required super.child,
    required this.controller,
  });

  static HomeTabControllerProvider of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<HomeTabControllerProvider>();
    assert(result != null, 'No HomeTabControllerProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) => false;
}
