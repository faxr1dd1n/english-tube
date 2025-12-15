import 'package:en_tube/src/bloc/home/home_bloc.dart';
import 'package:en_tube/src/constraints/app_color.dart';
import 'package:en_tube/src/model/story_model.dart';
import 'package:en_tube/src/service/firebase_auth_service.dart';
import 'package:en_tube/src/ui/menu/home/items/home_story_widget.dart';
import 'package:en_tube/src/ui/menu/home/items/home_widgets_grid_vieew.dart';
import 'package:en_tube/src/widgets/app_bar_widget.dart';
import 'package:en_tube/src/widgets/lessons_page_view.dart';
import 'package:en_tube/src/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  Future<void> _loadUserData() async {
    // Reload user to get latest data
    await authService.value.currentUser?.reload();
    final user = authService.value.currentUser;
    if (user != null) {
      print("Loading user data...");
      print("Display Name: ${user.displayName}");
      print("Email: ${user.email}");
      setState(() {
        userName = user.displayName ?? "User";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(GetStoriesEvent())
        ..add(GetHomeWidgetsEvent()),
      child: Scaffold(
        backgroundColor: AppColor.generalColor,
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
                  if (state.storiesStatus.isInitial || state.storiesStatus.isInProgress) {
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.white,
                          strokeWidth: 3,
                        ),
                      ),
                    );
                  }

                  // Xatolik holati
                  if (state.storiesStatus == FormzSubmissionStatus.failure) {
                    return SizedBox(
                      height: 180,
                      child: Center(
                        child: Text(
                          'Error: ${state.errorMessage}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }

                  // Ma'lumot yo'q holati - default storylarni ko'rsatish
                  final stories = state.stories.isEmpty ? defaultStories : state.stories;

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
                  color: AppColor.generalColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    // Bloc bilan home widgets ma'lumotlarini olish
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        // Loading holati (initial yoki inProgress)
                        if (state.homeWidgetsStatus.isInitial || state.homeWidgetsStatus.isInProgress) {
                          return const SizedBox(
                            height: 90,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColor.white,
                                strokeWidth: 3,
                              ),
                            ),
                          );
                        }

                        // Xatolik holati
                        if (state.homeWidgetsStatus == FormzSubmissionStatus.failure) {
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
