import 'package:cloud_firestore/cloud_firestore.dart';

class MentorVideoModel {
  final String videoUrl;
  final String videoName;
  final int likeCount;
  final int dislikeCount;
  final int mentorId;

  MentorVideoModel({
    required this.videoUrl,
    required this.videoName,
    required this.likeCount,
    required this.dislikeCount,
    required this.mentorId
  });

  // Firestore'dan ma'lumot olish
  factory MentorVideoModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return MentorVideoModel(
      videoUrl: data['video_url'] ?? '',
      videoName: data['video_name'] ?? '',
      likeCount: data['like_count'] ?? 0,
      dislikeCount: data['dislike_count'] ?? 0,
      mentorId: data['mentor_id'] ?? 0,
    );
  }

  // Firestore'ga ma'lumot yuborish
  Map<String, dynamic> toFirestore() {
    return {
      'video_url': videoUrl,
      'video_name': videoName,
      'like_count': likeCount,
      'dislike_count': dislikeCount,
      'mentor_id': mentorId,
    };
  }
}
