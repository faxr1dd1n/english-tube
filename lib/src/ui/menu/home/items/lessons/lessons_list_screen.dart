import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:en_tube/src/widgets/lesson_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LessonsListScreen extends StatefulWidget {
  const LessonsListScreen({super.key});

  @override
  State<LessonsListScreen> createState() => _LessonsListScreenState();
}

class _LessonsListScreenState extends State<LessonsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: tr('lessons')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: LessonWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
