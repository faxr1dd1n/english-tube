import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/tutors/videos/video_page.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  // Test video URLs that allow embedding
  List<String> videoUrls = [
    "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    "https://youtu.be/jNQXAC9IVRw",
    "https://www.youtube.com/watch?v=9bZkp7q19f0",
    "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    "https://youtu.be/jNQXAC9IVRw",
    "https://www.youtube.com/watch?v=9bZkp7q19f0",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: const Color.fromARGB(
          255,
          255,
          255,
          255,
        ).withValues(alpha: 0.2),
        title: const Text('Videos', style: TextStyle(color: AppColor.white)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        physics: const ClampingScrollPhysics(),
        itemCount: videoUrls.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          return VideoThumbnail(
            videoUrl: videoUrls[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoPage(videoUrl: videoUrls[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VideoThumbnail extends StatelessWidget {
  final String videoUrl;
  final VoidCallback onTap;

  const VideoThumbnail({
    super.key,
    required this.videoUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.white,
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
              'English for begineers (Introduction)',
              style: TextStyle(
                color: AppColor.blue,
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
                Icon(Icons.thumb_up_alt, color: AppColor.blue),
                SizedBox(width: 8),
                Text(
                  '15K',
                  style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8),

                Icon(Icons.thumb_down, color: AppColor.gray400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
