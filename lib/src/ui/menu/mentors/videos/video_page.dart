import 'package:easy_localization/easy_localization.dart';
import 'package:en_tube/src/bloc/mentor/mentor_bloc.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/mentor_model.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final VideoModel model;

  const VideoPage({super.key, required this.model});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.model.videoUrl);
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
          appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'mentors.video_player'.tr()),
      ),
          
        
          body: BlocBuilder<MentorBloc, MentorState>(
            builder: (context, state) {
              // State'dan mentorni topish
              final mentor = state.mentors.firstWhere(
                (m) => m.mentorId == widget.model.mentorId,
                orElse: () => MentorModel(
                  mentorId: widget.model.mentorId,
                  mentorName: '',
                  description: '',
                  starCount: 0,
                  videos: [widget.model],
                ),
              );

              // Mentordan videoni topish
              final video = mentor.videos.firstWhere(
                (v) => v.videoId == widget.model.videoId,
                orElse: () => widget.model,
              );

              final likes = video.likes;
              final userId = authService.value.currentUser?.uid ?? '';

              // User ning like/dislike statusini topish
              bool isLiked = false;
              bool isDisliked = false;

              try {
                final userStatus =
                    likes.userIds.firstWhere((user) => user.id == userId);
                isLiked = userStatus.isLiked;
                isDisliked = userStatus.isDisliked;
              } catch (e) {
                // User topilmasa, false qoladi
              }

              return Column(
                children: [
                  player,
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (userId.isNotEmpty) {
                              context.read<MentorBloc>().add(
                                    ToggleLikeEvent(
                                      userId: userId,
                                      mentorId: widget.model.mentorId,
                                      videoId: widget.model.videoId,
                                    ),
                                  );
                            }
                          },
                          child: Icon(
                            Icons.thumb_up,
                            color: isLiked
                                ? const Color.fromARGB(255, 245, 201, 40)
                                : AppColor.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${likes.likeCount}',
                          style: const TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            if (userId.isNotEmpty) {
                              context.read<MentorBloc>().add(
                                    ToggleDislikeEvent(
                                      userId: userId,
                                      mentorId: widget.model.mentorId,
                                      videoId: widget.model.videoId,
                                    ),
                                  );
                            }
                          },
                          child: Icon(
                            Icons.thumb_down,
                            color: isDisliked ? Colors.red : AppColor.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${likes.dislikeCount}',
                          style: const TextStyle(
                            color: AppColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
