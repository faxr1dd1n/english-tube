import 'package:cloud_firestore/cloud_firestore.dart';

class HomeWidgetModel {
  String? id;
  String title;
  String imageUrl;

  HomeWidgetModel({
    this.id,
    required this.title,
    required this.imageUrl,
  });

  // Firestore'dan ma'lumot olish
  factory HomeWidgetModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return HomeWidgetModel(
      id: doc.id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Firestore'ga ma'lumot yuborish
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
