
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoryData {
  final String id;
  final String title;
  final String imageUrl;
  final List<StoryPageData> pages;
  final Color? borderColor;
  final Color? timelineColor;

  const StoryData({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.pages,
    this.borderColor,
    this.timelineColor,
  });

  // Firestore'dan ma'lumot olish
  factory StoryData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return StoryData(
      id: doc.id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      borderColor: data['borderColor'] != null
          ? Color(data['borderColor'] as int)
          : null,
      timelineColor: data['timelineColor'] != null
          ? Color(data['timelineColor'] as int)
          : null,
      pages: (data['pages'] as List<dynamic>?)
              ?.map((page) => StoryPageData.fromMap(page))
              .toList() ??
          [],
    );
  }

  // Firestore'ga ma'lumot yuborish
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'borderColor': borderColor?.value,
      'timelineColor': timelineColor?.value,
      'pages': pages.map((page) => page.toMap()).toList(),
    };
  }
}

class StoryPageData {
  final String text;
  final String imageUrl;
  final bool addBottomBar;

  const StoryPageData({
    required this.text,
    required this.imageUrl,
    this.addBottomBar = false,
  });

  // Map'dan StoryPageData yaratish
  factory StoryPageData.fromMap(Map<String, dynamic> map) {
    return StoryPageData(
      text: map['text'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      addBottomBar: map['addBottomBar'] ?? false,
    );
  }

  // Map'ga aylantirish
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'imageUrl': imageUrl,
      'addBottomBar': addBottomBar,
    };
  }
}

const List<StoryData> defaultStories = [
    StoryData(
      id: "1",
      title: "Travel whereever",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Color.fromARGB(255, 134, 119, 95),
      timelineColor: Colors.blue,
      pages: [
        StoryPageData(
          text: "Get a loan",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
          addBottomBar: false,
        ),
        StoryPageData(
          text: "Select a place where you want to go",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
          addBottomBar: false,
        ),
        StoryPageData(
          text: "Dream about the place and pay our interest",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
          addBottomBar: false,
        ),
      ],
    ),
    StoryData(
      id: "2",
      title: "Buy a house anywhere",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.orange,
      timelineColor: Colors.orange,
      pages: [
        StoryPageData(
          text: "You cannot buy a house. Live with it",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),
    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),

    StoryData(
      id: "3",
      title: "Want a new car?",
      imageUrl:
          "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5",
      borderColor: Colors.red,
      timelineColor: Colors.red,
      pages: [
        StoryPageData(
          text:
              "Want to buy a new car? Get our loan for the rest of your life!",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
        StoryPageData(
          text:
              "Can't return the loan? Don't worry, we'll take your soul as a collateral ;-)",
          imageUrl:
              "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
        ),
      ],
    ),
  ];
