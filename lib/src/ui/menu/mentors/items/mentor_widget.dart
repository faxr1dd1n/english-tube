import 'package:flutter_translate/flutter_translate.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/constraints/app_images.dart';
import 'package:en_tube/src/model/mentor_model.dart';
import 'package:en_tube/src/widgets/star_rating_widget.dart';
import 'package:flutter/material.dart';

class MentorWidget extends StatefulWidget {
  const MentorWidget({required this.mentorModel, super.key});
  final MentorModel mentorModel;
  @override
  State<MentorWidget> createState() => _MentorWidgetState();
}

class _MentorWidgetState extends State<MentorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              AppImages.mentor,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mentorModel.mentorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColor.dark,
                  ),
                ),
                Text(
                  widget.mentorModel.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.play_circle_outline_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      translate('mentors.videos_count', args: {'count': widget.mentorModel.videos.length.toString()}),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.remove_red_eye_outlined,
                //       size: 18,
                //       color: Colors.grey,
                //     ),
                //     SizedBox(width: 4),
                //     Text(
                //       '${100} views',
                //       style: TextStyle(color: Colors.grey),
                //     ),
                //   ],
                // ),
                Row(children: buildStarRating(widget.mentorModel.starCount)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
