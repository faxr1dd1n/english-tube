import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/ui/menu/home/items/home_story_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<StoryData> defaultStories = [
    StoryData(
      id: "1",
      title: "Travel whereever",
      imageUrl:
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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
          "https://www.lingualift.com/wp-content/uploads/2023/06/7494959.jpg",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: AppBar(
        backgroundColor: AppColor.geeralColor,
        elevation: 2,
        shadowColor: const Color.fromARGB(
          255,
          255,
          255,
          255,
        ).withValues(alpha: 0.2),
        title: const Text('Home', style: TextStyle(color: AppColor.white)),
      ),
      body: Column(
        children: [
          const HomeStoryWidget(stories: defaultStories),
          Center(
            child: Text('Home Screen', style: TextStyle(color: AppColor.white)),
          ),
        ],
      ),
    );
  }
}
