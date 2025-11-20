import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/tutors/items/mentor_widget.dart';
import 'package:en_tube/src/ui/menu/tutors/videos/videos_screen.dart';
import 'package:flutter/material.dart';

class MentorsScreen extends StatefulWidget {
  const MentorsScreen({super.key});

  @override
  State<MentorsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<MentorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        title: const Text('Mentors', style: TextStyle(color: AppColor.white)),
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
            child: MentorWidget(),
          );
        },
      ),
    );
  }
}
