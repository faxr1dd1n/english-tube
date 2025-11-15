import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/lessons/items/lesson_widget.dart';
import 'package:en_tube/src/ui/menu/lessons/videos/videos_screen.dart';
import 'package:flutter/material.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        title: const Text('Lessons', style: TextStyle(color: AppColor.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideosScreen()),
              );
            },
            child: LessonWidget(),
          );
        },
      ),
    );
  }
}
