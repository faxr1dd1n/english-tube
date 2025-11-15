import 'package:en_tube/src/ui/menu/videos/items/youtube_video_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatelessWidget {
  final String videoUrl;

  const VideoPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Player")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: YoutubeVideoPlayer(videoUrl: videoUrl),
      ),
    );
  }
}
