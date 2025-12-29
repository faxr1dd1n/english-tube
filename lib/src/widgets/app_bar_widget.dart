import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    required this.title,
    this.backgroundColor,
    this.isCenterTitle,
    this.textStyle,
    super.key,
  });
  final String title;
  final Color? backgroundColor;
  final bool? isCenterTitle;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: AppColor.white,
      centerTitle: isCenterTitle ?? true,
      backgroundColor: backgroundColor ?? AppColor.generalColor,
      elevation: 2,
      shadowColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ).withValues(alpha: 0.2),
      title: Text(
        title,
        style:
            textStyle ??
            TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
