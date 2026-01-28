import 'package:flutter_translate/flutter_translate.dart';
import 'package:en_tube/src/bloc/mentor/mentor_bloc.dart';
import 'package:en_tube/src/constraints/app_icons.dart';
import 'package:en_tube/src/widgets/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

final List<DailyWord> dailyWordsPool = [
  DailyWord(en: "Improve", uz: "Yaxshilamoq", ru: "Улучшать"),
  DailyWord(en: "Achieve", uz: "Erishmoq", ru: "Достигать"),
  DailyWord(en: "Effort", uz: "Sa'y-harakat", ru: "Усилие"),
  DailyWord(en: "Support", uz: "Qo‘llab-quvvatlash", ru: "Поддержка"),
  DailyWord(en: "Focus", uz: "Diqqatni jamlash", ru: "Сосредоточенность"),
  DailyWord(en: "Growth", uz: "O‘sish", ru: "Рост"),
  DailyWord(en: "Success", uz: "Muvaffaqiyat", ru: "Успех"),
  DailyWord(en: "Failure", uz: "Muvaffaqiyatsizlik", ru: "Неудача"),
  DailyWord(en: "Confidence", uz: "O‘ziga ishonch", ru: "Уверенность"),
  DailyWord(en: "Discipline", uz: "Intizom", ru: "Дисциплина"),
  DailyWord(en: "Patience", uz: "Sabr", ru: "Терпение"),
  DailyWord(en: "Skill", uz: "Ko‘nikma", ru: "Навык"),
  DailyWord(en: "Knowledge", uz: "Bilim", ru: "Знание"),
  DailyWord(en: "Practice", uz: "Mashq", ru: "Практика"),
  DailyWord(en: "Goal", uz: "Maqsad", ru: "Цель"),
  DailyWord(en: "Result", uz: "Natija", ru: "Результат"),
  DailyWord(en: "Challenge", uz: "Qiyinchilik", ru: "Вызов"),
  DailyWord(en: "Opportunity", uz: "Imkoniyat", ru: "Возможность"),
  DailyWord(en: "Decision", uz: "Qaror", ru: "Решение"),
  DailyWord(en: "Motivation", uz: "Motivatsiya", ru: "Мотивация"),
  DailyWord(en: "Habit", uz: "Odat", ru: "Привычка"),
  DailyWord(en: "Experience", uz: "Tajriba", ru: "Опыт"),
  DailyWord(en: "Strength", uz: "Kuch", ru: "Сила"),
  DailyWord(en: "Weakness", uz: "Zaiflik", ru: "Слабость"),
  DailyWord(en: "Progress", uz: "Taraqqiyot", ru: "Прогресс"),
  DailyWord(en: "Responsibility", uz: "Mas'uliyat", ru: "Ответственность"),
  DailyWord(en: "Consistency", uz: "Barqarorlik", ru: "Последовательность"),
  DailyWord(en: "Creativity", uz: "Ijodkorlik", ru: "Креативность"),
  DailyWord(en: "Leadership", uz: "Yetakchilik", ru: "Лидерство"),
  DailyWord(en: "Successor", uz: "Merosxo‘r", ru: "Преемник"),
];

Future<bool> shouldShowDailyWords() async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateTime.now().toIso8601String().substring(0, 10);

  final completedDate = prefs.getString('daily_words_completed_date');
  return completedDate != today;
}

class DailyWord {
  final String en;
  final String uz;
  final String ru;

  DailyWord({required this.en, required this.uz, required this.ru});
}

List<DailyWord> pick3Words() {
  final random = Random();
  final shuffled = List<DailyWord>.from(dailyWordsPool)..shuffle(random);
  return shuffled.take(3).toList();
}

Future<void> markDailyWordsCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateTime.now().toIso8601String().substring(0, 10);
  await prefs.setString('daily_words_completed_date', today);
}

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

  // Daily words overlay state
  bool _isCheckingDailyWords = true;
  bool _showDailyWordsOverlay = false;
  List<DailyWord> _dailyWords = [];

  Widget _buildPageNavigator(NavItemEnum tabItem) =>
      TabNavigator(navigatorKey: _navigatorKeys[tabItem]!, tabItem: tabItem);

  Future<void> _checkDailyWords() async {
    final show = await shouldShowDailyWords();

    if (show) {
      _dailyWords = pick3Words();
      setState(() {
        _showDailyWordsOverlay = true;
        _isCheckingDailyWords = false;
      });
    } else {
      setState(() {
        _showDailyWordsOverlay = false;
        _isCheckingDailyWords = false;
      });
    }
  }

  String getTranslatedWord(DailyWord word, BuildContext context) {
    final locale = LocalizedApp.of(context).delegate.currentLocale.languageCode;

    switch (locale) {
      case 'ru':
        return word.ru;
      case 'uz':
        return word.uz;
      default:
        return word.uz; // fallback
    }
  }

  void _dismissDailyWordsOverlay() async {
    await markDailyWordsCompleted();
    setState(() {
      _showDailyWordsOverlay = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkDailyWords();

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
      msg: translate("common.press_again_to_exit"),
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

  Widget _buildDailyWordsOverlay() {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.primary,
            colors.primary.withOpacity(0.92),
            colors.primary.withOpacity(0.85),
          ],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            /// ❌ CLOSE
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.close, color: colors.onPrimary, size: 28),
                onPressed: _dismissDailyWordsOverlay,
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 48),
                Text(
                  "Daily English Words",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Learn 3 new words every day",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 28),

                /// WORDS
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _dailyWords.length,
                    itemBuilder: (_, i) {
                      final w = _dailyWords[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colors.surface.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colors.onPrimary.withOpacity(0.15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              w.en,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colors.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              getTranslatedWord(w, context),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onPrimary.withOpacity(0.75),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// BUTTON
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.onPrimary,
                      foregroundColor: colors.primary,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: _dismissDailyWordsOverlay,
                    child: const Text("Boshlash"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Loading yoki overlay ko'rsatilayotganda MainScreen ko'rinmasligi uchun
    if (_isCheckingDailyWords || _showDailyWordsOverlay) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: _isCheckingDailyWords
            ? const SizedBox.shrink() // Yuklanayotganda bo'sh (primary rangda)
            : _buildDailyWordsOverlay(),
      );
    }

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
                      label: translate('navigation.home'),
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
                      label: translate('navigation.mentors'),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.learnMenu,
                        color: _selectedIndex == 2
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: translate('navigation.learn'),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.chartMenu,
                        color: _selectedIndex == 3
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: translate('navigation.progress'),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppIcons.profileMenu,
                        color: _selectedIndex == 4
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                      label: translate('navigation.profile'),
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
