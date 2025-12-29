import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/providers/locale_provider.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/service/run_app_services.dart';
import 'package:en_tube/src/ui/login/login_screen.dart';
import 'package:en_tube/src/ui/menu/main_screen.dart';
import 'package:en_tube/src/ui/on_boarding/about_app_video_screen.dart';
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
  await EasyLocalization.ensureInitialized();

  // App ochilishida user name ni yuklab saqlash
  await RunAppServices.loadAndSaveUserName();

  // Saqlangan tilni yuklash
  final prefs = await SharedPreferences.getInstance();
  final savedLanguageCode = prefs.getString('language_code') ?? 'uz';
  final savedLocale = Locale(savedLanguageCode);

  final isFirstOpenApp = await RunAppServices.getIsFirstOpenApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: EasyLocalization(
        supportedLocales: const [Locale('uz'), Locale('en'), Locale('ru')],
        path: 'assets/translations',
        startLocale: savedLocale, // Saqlangan tildan boshlash
        fallbackLocale: const Locale('uz'),
        saveLocale: false, // Provider orqali saqlaymiz
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
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.lightTheme,
          themeMode: ThemeMode.system,
          locale: localeProvider.locale,
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
                    return const MainScreen(key: ValueKey('main_screen'));
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
      },
    );
  }
}
