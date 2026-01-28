import 'package:flutter_translate/flutter_translate.dart';
import 'package:en_tube/src/bloc/mentor/mentor_bloc.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/mentor_model.dart';
import 'package:en_tube/src/ui/menu/mentors/videos/video_page.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:en_tube/src/widgets/app_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({required this.data, super.key});
  final MentorModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.generalColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: translate('mentors.videos')),
      ),
      body: BlocBuilder<MentorBloc, MentorState>(
        builder: (context, state) {
          // State'dan mentorni topish
          final mentor = state.mentors.firstWhere(
            (m) => m.mentorId == data.mentorId,
            orElse: () => data,
          );

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                AppSearchWidget(),
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: mentor.videos.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (_, index) {
                    return VideoThumbnail(
                      model: mentor.videos[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<MentorBloc>(),
                              child: VideoPage(model: mentor.videos[index]),
                            ),
                          ),
                        );
                      },
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

class VideoThumbnail extends StatelessWidget {
  final VideoModel model;
  final VoidCallback onTap;

  const VideoThumbnail({super.key, required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(model.videoUrl);
    if (videoId == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(232, 22, 75, 167),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              model.videoName,
              style: TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),

            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.thumb_up_alt, color: AppColor.white),
                SizedBox(width: 8),
                Text(
                  model.likes.likeCount.toString(),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 12),

                Icon(Icons.thumb_down, color: AppColor.gray300),
                SizedBox(width: 8),
                Text(
                  model.likes.dislikeCount.toString(),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
