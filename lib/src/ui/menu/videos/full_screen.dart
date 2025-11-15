import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeFullScreenPage extends StatefulWidget {
  final String videoUrl;

  const YoutubeFullScreenPage({super.key, required this.videoUrl});

  @override
  State<YoutubeFullScreenPage> createState() => _YoutubeFullScreenPageState();
}

class _YoutubeFullScreenPageState extends State<YoutubeFullScreenPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final id = YoutubePlayer.convertUrlToId(widget.videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        controlsVisibleAtStart: true,
      ),
    );

    /// Fullscreenga avtomatik kiradi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.toggleFullScreenMode();
    });

    /// Orientatsiya: landscape
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();

    /// Normal holatga qaytarish
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) => player,
      ),
    );
  }
}
