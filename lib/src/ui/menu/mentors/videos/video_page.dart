import 'package:en_tube/src/constraints/app_color.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String videoUrl;

  const VideoPage({super.key, required this.videoUrl});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColor.generalColor,
          appBar: AppBar(
            foregroundColor: AppColor.white,
            backgroundColor: AppColor.generalColor,
            title: const Text(
              'Video Player',
              style: TextStyle(color: AppColor.white),
            ),
          ),
          body: Column(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.thumb_up, color: AppColor.white, size: 30),
                    const SizedBox(width: 8),
                    const Text(
                      '10K',
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.thumb_down,
                      color: AppColor.white,
                      size: 30,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.bookmark_border,
                      color: AppColor.white,
                      size: 30,
                    ),
                  ],
                ),

              ),
              Container(
                height: 0.5,
                color: const Color.fromARGB(116, 255, 255, 255),
              )
            ],
          ),
        );
      },
    );
  }
}
