import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:en_tube/src/model/home_widget_model.dart';

class FirestoreHomeWidgetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'home_widget';

  // Barcha home widgetlarni bir marta olish (realtime emas)
  Future<List<HomeWidgetModel>> getHomeWidgets() async {
    final snapshot = await _firestore.collection(_collectionName).get();

    return snapshot.docs
        .map((doc) => HomeWidgetModel.fromFirestore(doc))
        .toList();
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
