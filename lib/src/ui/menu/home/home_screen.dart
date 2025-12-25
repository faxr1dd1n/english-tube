import 'package:en_tube/src/bloc/home/home_bloc.dart';
import 'package:en_tube/src/model/story_model.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/service/run_app_services.dart';
import 'package:en_tube/src/ui/menu/home/items/home_story_widget.dart';
import 'package:en_tube/src/ui/menu/home/items/home_widgets_grid_vieew.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:en_tube/src/widgets/lessons_page_view.dart';
import 'package:en_tube/src/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserNameFromCache();
    _refreshUserNameInBackground();
  }

  // Avval cache'dan tezda yuklash
  Future<void> _loadUserNameFromCache() async {
    final cachedName = await RunAppServices.getUserName();
    if (cachedName != null && cachedName.isNotEmpty) {
      setState(() {
        userName = cachedName;
      });
    }
  }

  // Background da yangilash
  Future<void> _refreshUserNameInBackground() async {
    try {
      await authService.value.currentUser?.reload();
      final user = authService.value.currentUser;
      if (user != null) {
        final displayName = user.displayName ?? "User";
        // Cache'ga saqlash
        await RunAppServices.saveUserName(displayName);
        // UI ni yangilash
        if (mounted) {
          setState(() {
            userName = displayName;
          });
        }
      }
    } catch (e) {
      print("Error refreshing user name: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(GetStoriesEvent())
        ..add(GetHomeWidgetsEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
            title: 'Welcome $userName! 🤗',
            isCenterTitle: false,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Bloc bilan story ma'lumotlarini olish
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  // Loading holati (initial yoki inProgress)
                  if (state.storiesStatus.isInitial ||
                      state.storiesStatus.isInProgress) {
                    return SizedBox(
                      height: 170.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemBuilder: (_, __) {
                            return Column(
                              children: [
                                SizedBox(height: 10),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }

                  // Xatolik holati
                  if (state.storiesStatus == FormzSubmissionStatus.failure) {
                    return SizedBox(
                      height: 170,
                      child: Center(
                        child: Text(
                          'Error: ${state.errorMessage}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }

                  // Ma'lumot yo'q holati - default storylarni ko'rsatish
                  final stories = state.stories.isEmpty
                      ? defaultStories
                      : state.stories;

                  return HomeStoryWidget(stories: stories);
                },
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        255,
                        255,
                        255,
                        255,
                      ).withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -4),
                    ),
                  ],
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // Bloc bilan home widgets ma'lumotlarini olish
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        // Loading holati (initial yoki inProgress)
                        if (state.homeWidgetsStatus.isInitial ||
                            state.homeWidgetsStatus.isInProgress) {
                          return SizedBox(
                      height: 90.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 14),
                          itemBuilder: (_, __) {
                            return Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                
                        }

                        // Xatolik holati
                        if (state.homeWidgetsStatus ==
                            FormzSubmissionStatus.failure) {
                          return SizedBox(
                            height: 120,
                            child: Center(
                              child: Text(
                                'Error: ${state.errorMessage}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }

                        // Ma'lumot yo'q holati
                        final homeWidgets = state.homeWidgets;

                        return HomeWidgetsGridVieew(widgetModel: homeWidgets);
                      },
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TitleWidget(),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 200, child: LessonsPageView()),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TitleWidget(),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 200, child: LessonsPageView()),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
