import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/home_wdget_model.dart';
import 'package:en_tube/src/model/story_model.dart';
import 'package:en_tube/src/service/firestore_home_widget_service.dart';
import 'package:en_tube/src/service/firestore_story_service.dart';
import 'package:en_tube/src/ui/menu/home/items/home_story_widget.dart';
import 'package:en_tube/src/ui/menu/home/items/home_widgets_grid_vieew.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:en_tube/src/widgets/lessons_page_view.dart';
import 'package:en_tube/src/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storyService = FirestoreStoryService();
    final homeWidgetService = FirestoreHomeWidgetService();

    return Scaffold(
      backgroundColor: AppColor.geeralColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'Home'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            // Firebase'dan story ma'lumotlarini olish
            StreamBuilder<List<StoryData>>(
              stream: storyService.getStoriesStream(),
              builder: (context, snapshot) {
                // Loading holati
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 180,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                // Xatolik holati
                if (snapshot.hasError) {
                  return SizedBox(
                    height: 180,
                    child: Center(child: Text('Error: ${snapshot.error}')),
                  );
                }

                // Ma'lumot yo'q holati - default storylarni ko'rsatish
                final stories = snapshot.data ?? defaultStories;

                return HomeStoryWidget(stories: stories);
              },
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 37, 72, 161),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  StreamBuilder<List<HomeWidgetModel>>(
                    stream: homeWidgetService.getHomeWidgetsStream(),
                    builder: (context, snapshot) {
                      // Loading holati
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: 180,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      // Xatolik holati
                      if (snapshot.hasError) {
                        return SizedBox(
                          height: 180,
                          child: Center(
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        );
                      }

                      // Ma'lumot yo'q holati - default storylarni ko'rsatish
                      final homeWidgets = snapshot.data ?? [];

                      return HomeWidgetsGridVieew(widgetModel: homeWidgets);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TitleWidget(),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 200, child: LessonsPageView()),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TitleWidget(),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 200, child: LessonsPageView()),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
