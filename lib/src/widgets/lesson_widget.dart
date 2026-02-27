import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/home/items/lessons/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tr('courses.quick_english_a2'),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            tr('courses.achieve_high_levels'),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => const LessonScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            child: Text(
              tr('common.start'),
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
