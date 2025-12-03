import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({required this.title, this.backgroundColor, super.key});
  final String title;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:backgroundColor?? AppColor.generalColor,
      elevation: 2,
      shadowColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ).withValues(alpha: 0.2),
      title: Text(title, style: TextStyle(color: AppColor.white)),
    );
  }
}
