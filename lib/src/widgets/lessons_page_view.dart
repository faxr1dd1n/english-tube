import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';

class LessonsPageView extends StatefulWidget {
  const LessonsPageView({super.key});

  @override
  State<LessonsPageView> createState() => _LessonsPageViewState();
}

class _LessonsPageViewState extends State<LessonsPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.9),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      // padding: EdgeInsets.symmetric(horizontal: 24),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(right: 10, left: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'courses.quick_english_a2'.tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'courses.achieve_high_levels'.tr(),
              textAlign: TextAlign.center,

              maxLines: 2,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: Text('common.start'.tr())),
          ],
        ),
      ),
    );
  }
}
