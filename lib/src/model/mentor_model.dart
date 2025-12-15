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
      videoList = List<Map<String, dynamic>>.from(
        data['videos'],
      ).map((v) => VideoModel.fromMap(v)).toList();
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
  final int mentorId;
  final int videoId;

  final LikeModel likes;

  VideoModel({
    required this.videoUrl,
    required this.videoName,
    required this.mentorId,
    required this.videoId,
    required this.likes,
  });

  // Map orqali Firestore'dan olish
  factory VideoModel.fromMap(Map<String, dynamic> data) {
    return VideoModel(
      videoUrl: data['video_url'] ?? '',
      videoName: data['video_name'] ?? '',
      mentorId: data['mentor_id'] ?? 0,
      videoId: data['video_id'] ?? 0,
      likes: data['likes'] != null
          ? LikeModel.fromMap(data['likes'] as Map<String, dynamic>)
          : LikeModel(
              userIds: [],
              likeCount: 0,
              dislikeCount: 0,
            ),
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
      'mentor_id': mentorId,
      'video_id': videoId,
      'likes': likes,
    };
  }
}

class LikeModel {
  final List<UserLikeStatus> userIds;
  final int likeCount;
  final int dislikeCount;

  LikeModel({
    required this.userIds,
    required this.likeCount,
    required this.dislikeCount,
  });

  factory LikeModel.fromMap(Map<String, dynamic> data) {
    List<UserLikeStatus> userIdsList = [];
    if (data['user_ids'] != null && data['user_ids'] is List) {
      userIdsList = (data['user_ids'] as List)
          .map((item) => UserLikeStatus.fromMap(item as Map<String, dynamic>))
          .toList();
    }

    return LikeModel(
      userIds: userIdsList,
      likeCount: data['like_count'] ?? 0,
      dislikeCount: data['dislike_count'] ?? data['dislike_cout'] ?? 0, // typo fix
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_ids': userIds.map((user) => user.toMap()).toList(),
      'like_count': likeCount,
      'dislike_count': dislikeCount,
    };
  }
}

class UserLikeStatus {
  final String id;
  final bool isLiked;
  final bool isDisliked;

  UserLikeStatus({
    required this.id,
    required this.isLiked,
    required this.isDisliked,
  });

  factory UserLikeStatus.fromMap(Map<String, dynamic> data) {
    return UserLikeStatus(
      id: data['id'] ?? '',
      isLiked: data['is_liked'] ?? false,
      isDisliked: data['is_disliked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'is_liked': isLiked,
      'is_disliked': isDisliked,
    };
  }
}
