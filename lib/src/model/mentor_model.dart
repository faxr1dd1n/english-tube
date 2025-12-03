import 'package:cloud_firestore/cloud_firestore.dart';

class MentorModel {
  final int mentorId;
  final String mentorName;
  final String description;
  final double starCount;
  final int videoCount;
  final int viewCount;

  MentorModel({
    required this.mentorId,
    required this.mentorName,
    required this.description,
    required this.starCount,
    required this.videoCount,
    required this.viewCount,
  });

  // Firestore'dan ma'lumot olish
  factory MentorModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return MentorModel(
      mentorId: data['mentor_id'] ?? 0,
      mentorName: data['mentor_name'] ?? '',
      description: data['description'] ?? '',
      starCount: data['star_count'] ?? 0,
      videoCount: data['video_count'] ?? 0,
      viewCount: data['view_count'] ?? 0,
    );
  }

  // Firestore'ga ma'lumot yuborish
  Map<String, dynamic> toFirestore() {
    return {
      'mentor_id': mentorId,
      'mentor_name': mentorName,
      'description': description,
      'star_count': starCount,
      'video_count': videoCount,
      'view_count': viewCount,
    };
  }
}
