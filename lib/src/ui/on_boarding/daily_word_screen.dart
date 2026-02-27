import 'dart:math';

import 'package:en_tube/src/ui/menu/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DailyWordScreen extends StatefulWidget {
  const DailyWordScreen({super.key});

  @override
  State<DailyWordScreen> createState() => _DailyWordScreenState();
}

class _DailyWordScreenState extends State<DailyWordScreen> {
  List<DailyWord> _dailyWords = [];

  void _goToMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainScreen(key: ValueKey('main_screen')),
      ),
    );
  }

  String getTranslatedWord(DailyWord word, BuildContext context) {
    final locale = context.locale.languageCode;

    switch (locale) {
      case 'ru':
        return word.ru;
      case 'uz':
        return word.uz;
      default:
        return word.uz; // fallback
    }
  }

  @override
  void initState() {
    _dailyWords = pick3Words();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Scaffold(
      body: Container(
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
                  onPressed: _goToMainScreen,
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
                          padding: const EdgeInsets.all(18),
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
                              // English word + category badge
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      w.en,
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            color: colors.onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.onPrimary.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      w.wordCategory.name,
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                            color: colors.onPrimary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Translation
                              Text(
                                getTranslatedWord(w, context),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: colors.onPrimary.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Divider(
                                color: colors.onPrimary.withOpacity(0.15),
                                height: 1,
                              ),
                              const SizedBox(height: 12),

                              // Description
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 16,
                                    color: colors.onPrimary.withOpacity(0.6),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      w.description,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: colors.onPrimary.withOpacity(
                                              0.75,
                                            ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Example
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.format_quote,
                                    size: 16,
                                    color: colors.onPrimary.withOpacity(0.6),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      w.example,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: colors.onPrimary.withOpacity(
                                              0.65,
                                            ),
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                  ),
                                ],
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
                      onPressed: _goToMainScreen,
                      child: const Text("Boshlash"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<DailyWord> dailyWordsPool = [
  DailyWord(
    en: "Improve",
    uz: "Yaxshilamoq",
    ru: "Улучшать",
    wordCategory: WordCategory.verb,
    description: "To make something better.",
    example: "You should improve your English every day.",
  ),
  DailyWord(
    en: "Achieve",
    uz: "Erishmoq",
    ru: "Достигать",
    wordCategory: WordCategory.verb,
    description: "To successfully reach a goal.",
    example: "She achieved her goals through hard work.",
  ),
  DailyWord(
    en: "Effort",
    uz: "Sa'y-harakat",
    ru: "Усилие",
    wordCategory: WordCategory.noun,
    description: "An attempt to do something.",
    example: "Learning English requires effort.",
  ),
  DailyWord(
    en: "Support",
    uz: "Qo‘llab-quvvatlash",
    ru: "Поддержка",
    wordCategory: WordCategory.noun,
    description: "Help or assistance.",
    example: "Family support is very important.",
  ),
  DailyWord(
    en: "Focus",
    uz: "Diqqatni jamlash",
    ru: "Сосредоточенность",
    wordCategory: WordCategory.noun,
    description: "The ability to concentrate.",
    example: "Stay focused on your goals.",
  ),
  DailyWord(
    en: "Growth",
    uz: "O‘sish",
    ru: "Рост",
    wordCategory: WordCategory.noun,
    description: "Increase in size or development.",
    example: "Personal growth takes time.",
  ),
  DailyWord(
    en: "Success",
    uz: "Muvaffaqiyat",
    ru: "Успех",
    wordCategory: WordCategory.noun,
    description: "Achieving something desired.",
    example: "Success comes with discipline.",
  ),
  DailyWord(
    en: "Failure",
    uz: "Muvaffaqiyatsizlik",
    ru: "Неудача",
    wordCategory: WordCategory.noun,
    description: "Lack of success.",
    example: "Failure is part of learning.",
  ),
  DailyWord(
    en: "Confidence",
    uz: "O‘ziga ishonch",
    ru: "Уверенность",
    wordCategory: WordCategory.noun,
    description: "Belief in yourself.",
    example: "Confidence helps you speak fluently.",
  ),
  DailyWord(
    en: "Discipline",
    uz: "Intizom",
    ru: "Дисциплина",
    wordCategory: WordCategory.noun,
    description: "Controlled behavior and habits.",
    example: "Discipline leads to success.",
  ),
];

class DailyWord {
  final String en;
  final String uz;
  final String ru;
  final WordCategory wordCategory;
  final String description;
  final String example;

  DailyWord({
    required this.en,
    required this.uz,
    required this.ru,
    required this.wordCategory,
    required this.description,
    required this.example,
  });
}

enum WordCategory {
  verb,
  adjective,
  noun,
  adverb,
  pronoun,
  preposition,
  conjunction,
  interjection,
  article,
}

List<DailyWord> pick3Words() {
  final random = Random();
  final shuffled = List<DailyWord>.from(dailyWordsPool)..shuffle(random);
  return shuffled.take(1).toList();
}
