import 'package:cached_network_image/cached_network_image.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/story_model.dart';
import 'package:en_tube/src/widgets/custom_cachedd_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';

class HomeStoryWidget extends StatefulWidget {
  final List<StoryData> stories;

  const HomeStoryWidget({super.key, required this.stories});

  @override
  State<HomeStoryWidget> createState() => _HomeStoryWidgetState();
}

class _HomeStoryWidgetState extends State<HomeStoryWidget> {
  static const double _borderRadius = 30.0;
  final StoryTimelineController storyController = StoryTimelineController();

  @override
  void initState() {
    super.initState();
    storyController.addListener(_onStoryEvent);
  }

  void _onStoryEvent(event, storyId) {
    debugPrint('event=> $event  storyId $storyId');
  }

  @override
  void dispose() {
    storyController.removeListener(_onStoryEvent);
    super.dispose();
  }

  Widget _createStoryPage(StoryPageData pageData) {
    return StoryPageScaffold(
      bottomNavigationBar: pageData.addBottomBar
          ? SizedBox(
              width: double.infinity,
              height: kBottomNavigationBarHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(_borderRadius),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomCachedImage(
              imageUrl: pageData.imageUrl,
              fit: BoxFit.contain,
            ),
          ),

          // Text overlay
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Text(
              pageData.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonChild(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100.0),
          Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildButtonDecoration(String imageUrl) {
    return BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(_borderRadius - 3),
      image: DecorationImage(
        image: CachedNetworkImageProvider(imageUrl),
        fit: BoxFit.cover,
      ),
    );
  }

  BoxDecoration _buildBorderDecoration(Color color) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomCenter,
        colors: [
          Colors.pink,
          Colors.pink,
          Colors.pink,
          Colors.pink,
          Colors.red,
          Colors.red,
          Colors.red,
          const Color.fromARGB(255, 255, 134, 59),
          const Color.fromARGB(255, 255, 180, 59),
          const Color.fromARGB(255, 255, 134, 59),
        ],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
      border: Border.fromBorderSide(BorderSide(color: color, width: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoryListView(
      listHeight: 170.0,
      pageTransform: const StoryPage3DTransform(),
      buttonDatas: widget.stories.map((story) {
        return StoryButtonData(
          storyId: story.id,
          storyController: storyController,
          timelineBackgroundColor: story.timelineColor ?? Colors.blue,
          buttonDecoration: _buildButtonDecoration(story.imageUrl),
          borderDecoration: _buildBorderDecoration(
            story.borderColor ?? const Color.fromARGB(255, 134, 119, 95),
          ),
          child: _buildButtonChild(story.title),
          storyPages: story.pages
              .map((page) => _createStoryPage(page))
              .toList(),
          segmentDuration: story.pages
              .map((_) => const Duration(seconds: 25))
              .toList(),
        );
      }).toList(),
    );
  }
}
