import 'package:en_tube/src/bloc/mentor/mentor_bloc.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/mentors/items/mentor_widget.dart';
import 'package:en_tube/src/ui/menu/mentors/videos/videos_screen.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:en_tube/src/widgets/app_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class MentorsScreen extends StatelessWidget {
  const MentorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.generalColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Mentors'),
      ),
      body: BlocBuilder<MentorBloc, MentorState>(
        builder: (context, state) {
          // Loading holati (initial yoki inProgress)
          if (state.mentorsStatus.isInitial || state.mentorsStatus.isInProgress) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.white,
                strokeWidth: 3,
              ),
            );
          }

          // Xatolik holati
          if (state.mentorsStatus == FormzSubmissionStatus.failure) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: TextStyle(color: AppColor.white),
              ),
            );
          }

          final mentors = state.mentors;

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
                            builder: (_) => BlocProvider.value(
                              value: context.read<MentorBloc>(),
                              child: VideosScreen(data: mentors[index]),
                            ),
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
