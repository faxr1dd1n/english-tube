import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/tutors/videos/items/youtube_video_player.dart';
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

  int? _currentPlayingIndex;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        title: const Text('Videos', style: TextStyle(color: AppColor.white)),
      ),
      body: Column(
        children: [
         SizedBox(height: 16),
          // Video list
          Expanded(
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              itemCount: videoUrls.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
              itemBuilder: (_, index) {
                return VideoListItem(
                  videoUrl: videoUrls[index],
                  isPlaying: _currentPlayingIndex == index,
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
          ),
                  SizedBox(height: 16),
      
       ],
      ),
    );
  }
}

class VideoListItem extends StatefulWidget {
  final String videoUrl;
  final bool isPlaying;
  final VoidCallback onTap;

  const VideoListItem({
    super.key,
    required this.videoUrl,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  String? _videoId;

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId == null) {
      return const SizedBox.shrink();
    }

    if (!widget.isPlaying) {
      // Show thumbnail with play button
      return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Thumbnail
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://img.youtube.com/vi/$_videoId/hqdefault.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Play button overlay
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
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
        ),
      );
    }

    // Show actual YouTube player
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: YoutubeVideoPlayer(videoUrl: widget.videoUrl),
      ),
    );
  }
}
