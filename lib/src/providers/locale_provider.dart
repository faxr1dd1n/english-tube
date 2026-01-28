import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('uz');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  // Saqlangan tilni yuklash
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'uz';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  // Tilni o'zgartirish (flutter_translate bilan)
  Future<void> setLocale(BuildContext context, Locale newLocale) async {
    if (_locale == newLocale) return;

    _locale = newLocale;

    // Tilni saqlash
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);

    notifyListeners();

    // flutter_translate ga yangi tilni bildirish (async gap dan keyin context.mounted check)
    if (context.mounted) {
      await changeLocale(context, newLocale.languageCode);
    }
  }
}
