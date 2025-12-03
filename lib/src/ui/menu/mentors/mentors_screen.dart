import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/mentor_model.dart';
import 'package:en_tube/src/service/firestore_mentor_service.dart';
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
  final mentorService = FirestoreMentorService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.generalColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Mentors'),
      ),
      body: StreamBuilder<List<MentorModel>>(
        stream: mentorService.getMetorsStream(),
        builder: (context, snapshot) {
          // Loading holati
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Xatolik holati
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Ma'lumot yo'q holati - default storylarni ko'rsatish
          final mentors = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),

                AppSearchWidget(),
                SizedBox(height: 4),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  itemCount: mentors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VideosScreen(mentorId: mentors[index].mentorId),
                          ),
                        );
                      },
                      child: MentorWidget(mentorModel: mentors[index]),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
