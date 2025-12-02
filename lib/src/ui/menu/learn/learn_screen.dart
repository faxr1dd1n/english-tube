import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/learn/items/learn_widget.dart';
import 'package:en_tube/src/ui/menu/mentors/videos/videos_screen.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Lessons'),
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
            child: LearnWidget(),
          );
        },
      ),
    );
  }
}
