import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/mentors/items/mentor_widget.dart';
import 'package:en_tube/src/ui/menu/mentors/videos/videos_screen.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:en_tube/src/widgets/app_search_widget.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Mentors'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),

            AppSearchWidget(),
            SizedBox(height: 4),
            ListView.builder(
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(),
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
          ],
        ),
      ),
    );
  }
}
