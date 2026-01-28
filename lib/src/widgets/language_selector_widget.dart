import 'package:flutter_translate/flutter_translate.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => Consumer<LocaleProvider>(
        builder: (context, provider, _) => Container(
          decoration: BoxDecoration(
            color: AppColor.generalColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),

              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 15),

              // Title
              Text(
                translate('select_language'),
                style: const TextStyle(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Language options
              _LanguageOption(
                languageName: 'O\'zbek',
                languageCode: 'uz',
                flagEmoji: '🇺🇿',
                isSelected: provider.locale.languageCode == 'uz',
              ),

              _LanguageOption(
                languageName: 'English',
                languageCode: 'en',
                flagEmoji: '🇬🇧',
                isSelected: provider.locale.languageCode == 'en',
              ),

              _LanguageOption(
                languageName: 'Русский',
                languageCode: 'ru',
                flagEmoji: '🇷🇺',
                isSelected: provider.locale.languageCode == 'ru',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) {
        String currentFlag = '';

        switch (localeProvider.locale.languageCode) {
          case 'uz':
            currentFlag = '🇺🇿';
            break;
          case 'en':
            currentFlag = '🇬🇧';
            break;
          case 'ru':
            currentFlag = '🇷🇺';
            break;
        }

        return GestureDetector(
          onTap: () => _showLanguageBottomSheet(context),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.translate_outlined, color: AppColor.white),
                const SizedBox(width: 6),
                Text(
                  translate('language'),
                  style: TextStyle(
                    color: AppColor.white.withValues(alpha: 0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(child: const SizedBox()),
                Text(currentFlag, style: const TextStyle(fontSize: 22)),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.white.withValues(alpha: 0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String languageName;
  final String languageCode;
  final String flagEmoji;
  final bool isSelected;

  const _LanguageOption({
    required this.languageName,
    required this.languageCode,
    required this.flagEmoji,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Avval bottom sheet ni yopamiz
        Navigator.pop(context);

        // Provider orqali tilni o'zgartiramiz (flutter_translate bilan)
        final localeProvider = Provider.of<LocaleProvider>(
          context,
          listen: false,
        );
        if (context.mounted) {
          await localeProvider.setLocale(context, Locale(languageCode));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(flagEmoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                languageName,
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
            isSelected?
              const Icon(Icons.check_circle, color: Colors.green, size: 24):
              Icon(Icons.check_circle,size: 
              24,color: AppColor.gray400,),
          ],
        ),
      ),
    );
  }
}
