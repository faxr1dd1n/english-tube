import 'package:cloud_firestore/cloud_firestore.dart';

class MentorModel {
  final int mentorId;
  final String mentorName;
  final String description;
  final double starCount;
  final List<VideoModel> videos;

  MentorModel({
    required this.mentorId,
    required this.mentorName,
    required this.description,
    required this.starCount,
    required this.videos,
  });

  // Firestore'dan ma'lumot olish
  factory MentorModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<VideoModel> videoList = [];
    if (data['videos'] != null) {
      videoList = List<Map<String, dynamic>>.from(data['videos'])
          .map((v) => VideoModel.fromMap(v))
          .toList();
    }

    return MentorModel(
      mentorId: data['mentor_id'] ?? 0,
      mentorName: data['mentor_name'] ?? '',
      description: data['description'] ?? '',
      starCount: (data['star_count'] ?? 0).toDouble(),
      videos: videoList,
    );
  }

  // Firestore'ga ma'lumot yuborish
  Map<String, dynamic> toFirestore() {
    return {
      'mentor_id': mentorId,
      'mentor_name': mentorName,
      'description': description,
      'star_count': starCount,
      'videos': videos.map((v) => v.toMap()).toList(),
    };
  }
}

class VideoModel {
  final String videoUrl;
  final String videoName;
  final int likeCount;
  final int dislikeCount;
  final int mentorId;

  VideoModel({
    required this.videoUrl,
    required this.videoName,
    required this.likeCount,
    required this.dislikeCount,
    required this.mentorId,
  });

  // Map orqali Firestore'dan olish
  factory VideoModel.fromMap(Map<String, dynamic> data) {
    return VideoModel(
      videoUrl: data['video_url'] ?? '',
      videoName: data['video_name'] ?? '',
      likeCount: data['like_count'] ?? 0,
      dislikeCount: data['dislike_count'] ?? 0,
      mentorId: data['mentor_id'] ?? 0,
    );
  }

  // DocumentSnapshot dan ham olish mumkin
  factory VideoModel.fromFirestore(DocumentSnapshot doc) {
    return VideoModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  // Firestore'ga map qilib yuborish
  Map<String, dynamic> toMap() {
    return {
      'video_url': videoUrl,
      'video_name': videoName,
      'like_count': likeCount,
      'dislike_count': dislikeCount,
      'mentor_id': mentorId,
    };
  }
}
