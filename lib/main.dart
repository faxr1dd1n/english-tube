import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/providers/locale_provider.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/service/run_app_services.dart';
import 'package:en_tube/src/ui/login/login_screen.dart';
import 'package:en_tube/src/ui/on_boarding/about_app_video_screen.dart';
import 'package:en_tube/src/ui/on_boarding/daily_word_screen.dart';
import 'package:en_tube/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // App ochilishida user name ni yuklab saqlash
  await RunAppServices.loadAndSaveUserName();

  // easy_localization initialization
  await EasyLocalization.ensureInitialized();

  // Saqlangan tilni yuklash
  final prefs = await SharedPreferences.getInstance();
  final savedLanguageCode = prefs.getString('language_code') ?? 'uz';

  final isFirstOpenApp = await RunAppServices.getIsFirstOpenApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('uz'), Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('uz'),
      startLocale: Locale(savedLanguageCode),
      child: ChangeNotifierProvider(
        create: (_) => LocaleProvider(),
        child: MyApp(isFirstOpenApp: isFirstOpenApp),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.isFirstOpenApp, super.key});
  final bool isFirstOpenApp;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      home: ValueListenableBuilder(
        valueListenable: authService,
        builder: (context, authService, child) {
          return StreamBuilder(
            stream: authService.authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.white,
                      strokeWidth: 3,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                return const DailyWordScreen();
              } else if (isFirstOpenApp) {
                return const LoginScreen();
              } else {
                return const AboutAppVideoScreen();
              }
            },
          );
        },
      ),
    );
  }
}
