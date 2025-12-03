import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/mentor_model.dart';
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
      height: 180,
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
            child: Image.network(
              'https://thumbs.dreamstime.com/b/avatar-teacher-book-his-hands-d-style-adorable-cartoon-310669103.jpg',
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.mentorModel.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${widget.mentorModel.videoCount} videos',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${widget.mentorModel.viewCount} views',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(children: _buildStarRating(widget.mentorModel.starCount)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _buildStarRating(double rating) {
  List<Widget> stars = [];
  int fullStars = rating.floor();
  bool hasHalfStar = (rating - fullStars) >= 0.5;

  for (int i = 0; i < fullStars; i++) {
    stars.add(Icon(Icons.star, color: AppColor.yellow));
  }

  if (hasHalfStar) {
    stars.add(Icon(Icons.star_half, color: AppColor.yellow));
  }

  while (stars.length < 5) {
    stars.add(Icon(Icons.star_border_outlined, color: AppColor.yellow));
  }

  return stars;
}
