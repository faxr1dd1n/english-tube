import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:en_tube/src/model/mentor_model.dart';

class FirestoreMentorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'mentors_list';

  // Stream orqali barcha home widgetlarni olish (real-time)
  Stream<List<MentorModel>> getMetorsStream() {
    return _firestore.collection(_collectionName).snapshots().map((snapshot) {
      final widgets = snapshot.docs.map((doc) {
        final widget = MentorModel.fromFirestore(doc);

        return widget;
      }).toList();

      return widgets;
    });
  }

  // Barcha home widgetlarni bir marta olish
  Future<List<MentorModel>> getMentors() async {
    final snapshot = await _firestore.collection(_collectionName).get();

    return snapshot.docs
        .map((doc) => MentorModel.fromFirestore(doc))
        .toList();
  }


// Video like ma'lumotlarini olish (count va status)
  Stream<LikeModel?> getVideoLikes({
    required int mentorId,
    required int videoId,
  }) {
    return _firestore.collection(_collectionName).snapshots().map((snapshot) {
      for (var doc in snapshot.docs) {
        final mentor = MentorModel.fromFirestore(doc);
        if (mentor.mentorId == mentorId) {
          for (var video in mentor.videos) {
            if (video.videoId == videoId) {
              return video.likes;
            }
          }
        }
      }
      return null;
    });
  }

  // Video like statusini tekshirish
  Stream<bool> isVideoLiked({
    required String userId,
    required int mentorId,
    required int videoId,
  }) {
    return _firestore.collection(_collectionName).snapshots().map((snapshot) {
      for (var doc in snapshot.docs) {
        final mentor = MentorModel.fromFirestore(doc);
        if (mentor.mentorId == mentorId) {
          for (var video in mentor.videos) {
            if (video.videoId == videoId) {
              // User ID ni listdan topish
              try {
                final userStatus = video.likes.userIds.firstWhere(
                  (user) => user.id == userId,
                );
                return userStatus.isLiked;
              } catch (e) {
                return false;
              }
            }
          }
        }
      }
      return false;
    });
  }

  // Video dislike statusini tekshirish
  Stream<bool> isVideoDisliked({
    required String userId,
    required int mentorId,
    required int videoId,
  }) {
    return _firestore.collection(_collectionName).snapshots().map((snapshot) {
      for (var doc in snapshot.docs) {
        final mentor = MentorModel.fromFirestore(doc);
        if (mentor.mentorId == mentorId) {
          for (var video in mentor.videos) {
            if (video.videoId == videoId) {
              // User ID ni listdan topish
              try {
                final userStatus = video.likes.userIds.firstWhere(
                  (user) => user.id == userId,
                );
                return userStatus.isDisliked;
              } catch (e) {
                return false;
              }
            }
          }
        }
      }
      return false;
    });
  }

  // Like buttonni toggle qilish
  Future<void> toggleLike({
    required String userId,
    required int mentorId,
    required int videoId,
  }) async {
    final snapshot = await _firestore.collection(_collectionName).get();

    for (var doc in snapshot.docs) {
      final mentor = MentorModel.fromFirestore(doc);
      if (mentor.mentorId == mentorId) {
        List<Map<String, dynamic>> updatedVideos = [];

        for (var video in mentor.videos) {
          if (video.videoId == videoId) {
            // User statusini topish
            UserLikeStatus? existingUser;
            try {
              existingUser =
                  video.likes.userIds.firstWhere((user) => user.id == userId);
            } catch (e) {
              existingUser = null;
            }

            int newLikeCount = video.likes.likeCount;
            int newDislikeCount = video.likes.dislikeCount;
            List<Map<String, dynamic>> updatedUserIds = [];

            // Boshqa userlarni qo'shish
            for (var user in video.likes.userIds) {
              if (user.id != userId) {
                updatedUserIds.add(user.toMap());
              }
            }

            // Hozirgi user uchun yangi status
            if (existingUser != null) {
              // User allaqachon mavjud
              if (existingUser.isLiked) {
                // Like ni olib tashlash
                newLikeCount--;
                // User ni listdan o'chirish (qayta qo'shmaymiz)
              } else {
                // Like qo'shish
                newLikeCount++;
                if (existingUser.isDisliked) {
                  // Agar dislike bosilgan bo'lsa, uni olib tashlash
                  newDislikeCount--;
                }
                // Yangi statusni qo'shish
                updatedUserIds.add({
                  'id': userId,
                  'is_liked': true,
                  'is_disliked': false,
                });
              }
            } else {
              // User birinchi marta like bosyapti
              newLikeCount++;
              updatedUserIds.add({
                'id': userId,
                'is_liked': true,
                'is_disliked': false,
              });
            }

            updatedVideos.add({
              'video_url': video.videoUrl,
              'video_name': video.videoName,
              'mentor_id': video.mentorId,
              'video_id': video.videoId,
              'likes': {
                'user_ids': updatedUserIds,
                'like_count': newLikeCount,
                'dislike_count': newDislikeCount,
              },
            });
          } else {
            updatedVideos.add(video.toMap());
          }
        }

        await doc.reference.update({'videos': updatedVideos});
        break;
      }
    }
  }

  // Dislike buttonni toggle qilish
  Future<void> toggleDislike({
    required String userId,
    required int mentorId,
    required int videoId,
  }) async {
    final snapshot = await _firestore.collection(_collectionName).get();

    for (var doc in snapshot.docs) {
      final mentor = MentorModel.fromFirestore(doc);
      if (mentor.mentorId == mentorId) {
        List<Map<String, dynamic>> updatedVideos = [];

        for (var video in mentor.videos) {
          if (video.videoId == videoId) {
            // User statusini topish
            UserLikeStatus? existingUser;
            try {
              existingUser =
                  video.likes.userIds.firstWhere((user) => user.id == userId);
            } catch (e) {
              existingUser = null;
            }

            int newLikeCount = video.likes.likeCount;
            int newDislikeCount = video.likes.dislikeCount;
            List<Map<String, dynamic>> updatedUserIds = [];

            // Boshqa userlarni qo'shish
            for (var user in video.likes.userIds) {
              if (user.id != userId) {
                updatedUserIds.add(user.toMap());
              }
            }

            // Hozirgi user uchun yangi status
            if (existingUser != null) {
              // User allaqachon mavjud
              if (existingUser.isDisliked) {
                // Dislike ni olib tashlash
                newDislikeCount--;
                // User ni listdan o'chirish (qayta qo'shmaymiz)
              } else {
                // Dislike qo'shish
                newDislikeCount++;
                if (existingUser.isLiked) {
                  // Agar like bosilgan bo'lsa, uni olib tashlash
                  newLikeCount--;
                }
                // Yangi statusni qo'shish
                updatedUserIds.add({
                  'id': userId,
                  'is_liked': false,
                  'is_disliked': true,
                });
              }
            } else {
              // User birinchi marta dislike bosyapti
              newDislikeCount++;
              updatedUserIds.add({
                'id': userId,
                'is_liked': false,
                'is_disliked': true,
              });
            }

            updatedVideos.add({
              'video_url': video.videoUrl,
              'video_name': video.videoName,
              'mentor_id': video.mentorId,
              'video_id': video.videoId,
              'likes': {
                'user_ids': updatedUserIds,
                'like_count': newLikeCount,
                'dislike_count': newDislikeCount,
              },
            });
          } else {
            updatedVideos.add(video.toMap());
          }
        }

        await doc.reference.update({'videos': updatedVideos});
        break;
      }
    }
  }

  // Bitta story qo'shish
  // Future<void> addStory(StoryData story) async {
  //   final data = story.toFirestore();
  //   data['createdAt'] = FieldValue.serverTimestamp();

  //   await _firestore.collection(_collectionName).add(data);
  // }

  // // Story yangilash
  // Future<void> updateStory(String storyId, StoryData story) async {
  //   await _firestore
  //       .collection(_collectionName)
  //       .doc(storyId)
  //       .update(story.toFirestore());
  // }

  // // Story o'chirish
  // Future<void> deleteStory(String storyId) async {
  //   await _firestore.collection(_collectionName).doc(storyId).delete();
  // }

  // // Default storylarni Firestore'ga yuklash (faqat bir marta)
  // Future<void> uploadDefaultStories(List<StoryData> stories) async {
  //   final batch = _firestore.batch();

  //   for (var story in stories) {
  //     final docRef = _firestore.collection(_collectionName).doc();
  //     final data = story.toFirestore();
  //     data['createdAt'] = FieldValue.serverTimestamp();
  //     batch.set(docRef, data);
  //   }

  //   await batch.commit();
  // }
}
