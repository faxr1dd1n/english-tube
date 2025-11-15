import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/lessons/videos/items/youtube_video_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatelessWidget {
  final String videoUrl;

  const VideoPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.geeralColor,
        title: const Text(
          "Video Player",
          style: TextStyle(color: AppColor.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: YoutubeVideoPlayer(videoUrl: videoUrl),
      ),
    );
  }
}
