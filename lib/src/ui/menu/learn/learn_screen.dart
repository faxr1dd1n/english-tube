import 'package:flutter_translate/flutter_translate.dart';
import 'package:en_tube/src/constraints/app_icons.dart';
import 'package:en_tube/src/model/mentor_model.dart';
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: translate('learn.title')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideosScreen(
                    data: MentorModel(
                      mentorId: 0,
                      mentorName: '',
                      description: '',
                      starCount: 3,
                      videos: [],
                    ),
                  ),
                ),
              );
            },
            child: LearnWidget(
              icon: AppIcons.bookA,
              title: translate('learn.reading'),
              description: translate('learn.lesson_description'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideosScreen(
                    data: MentorModel(
                      mentorId: 0,
                      mentorName: '',
                      description: '',
                      starCount: 3,
                      videos: [],
                    ),
                  ),
                ),
              );
            },
            child: LearnWidget(
              icon: AppIcons.notebookPen,
              title: translate('learn.grammar'),
              description: translate('learn.lesson_description'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideosScreen(
                    data: MentorModel(
                      mentorId: 0,
                      mentorName: '',
                      description: '',
                      starCount: 3,
                      videos: [],
                    ),
                  ),
                ),
              );
            },
            child: LearnWidget(
              icon: AppIcons.podcast,
              title: translate('learn.podcasts'),
              description: translate('learn.lesson_description'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideosScreen(
                    data: MentorModel(
                      mentorId: 0,
                      mentorName: '',
                      description: '',
                      starCount: 3,
                      videos: [],
                    ),
                  ),
                ),
              );
            },
            child: LearnWidget(
              icon: AppIcons.languages,
              title: translate('learn.translator'),
              description: translate('learn.lesson_description'),
            ),
          ),
        ],
      ),
    );
  }
}
