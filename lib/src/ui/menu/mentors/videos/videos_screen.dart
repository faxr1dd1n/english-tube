import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/mentor_video_model.dart';
import 'package:en_tube/src/service/firestore_mentor_video_service.dart';
import 'package:en_tube/src/ui/menu/mentors/videos/video_page.dart';
import 'package:en_tube/src/widgets/app_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({required this.mentorId, super.key});
  final int mentorId;
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final mentorVideoService = FirestoreMentorVideoService();
  // Test video URLs that allow embedding
  // List<String> videoUrls = [
  //   "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  //   "https://youtu.be/jNQXAC9IVRw",
  //   "https://www.youtube.com/watch?v=9bZkp7q19f0",
  //   "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  //   "https://youtu.be/jNQXAC9IVRw",
  //   "https://www.youtube.com/watch?v=9bZkp7q19f0",
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.generalColor,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.generalColor,
        elevation: 2,
        shadowColor: const Color.fromARGB(
          255,
          255,
          255,
          255,
        ).withValues(alpha: 0.2),
        title: const Text('Videos', style: TextStyle(color: AppColor.white)),
      ),
      body: StreamBuilder<List<MentorVideoModel>>(
        stream: mentorVideoService.getMetorVideoStream(widget.mentorId),
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
          final mentorVideos = snapshot.data ?? [];

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
                  itemCount: mentorVideos.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (_, index) {
                    return VideoThumbnail(
                      model: mentorVideos[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoPage(
                              videoUrl: mentorVideos[index].videoUrl,
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
  final MentorVideoModel model;
  final VoidCallback onTap;

  const VideoThumbnail({
    super.key,
    required this.model,
    required this.onTap,
  });

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
          color: AppColor.gray600,
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

            Row(
              children: [
                Icon(Icons.star, color: AppColor.yellow),
                Icon(Icons.star, color: AppColor.yellow),
                Icon(Icons.star, color: AppColor.yellow),
                Icon(Icons.star_half, color: AppColor.yellow),
                Icon(Icons.star_border_outlined, color: AppColor.yellow),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.thumb_up_alt, color: AppColor.white),
                SizedBox(width: 8),
                Text(
                  model.likeCount.toString(),
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
                  model.dislikeCount.toString(),
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
