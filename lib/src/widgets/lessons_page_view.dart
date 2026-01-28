import 'package:en_tube/src/widgets/lesson_widget.dart';
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
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(right: 10, left: 6),
        child: LessonWidget(),
      ),
    );
  }
}
