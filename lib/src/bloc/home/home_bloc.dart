import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:en_tube/src/model/story_model.dart';
import 'package:en_tube/src/model/home_widget_model.dart';
import 'package:en_tube/src/service/firestore_story_service.dart';
import 'package:en_tube/src/service/firestore_home_widget_service.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirestoreStoryService _storyService = FirestoreStoryService();
  final FirestoreHomeWidgetService _homeWidgetService = FirestoreHomeWidgetService();

  HomeBloc() : super(const HomeState()) {
    on<GetStoriesEvent>(_onGetStories);
    on<GetHomeWidgetsEvent>(_onGetHomeWidgets);
  }

  Future<void> _onGetStories(
    GetStoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(storiesStatus: FormzSubmissionStatus.inProgress));

    try {
      final stories = await _storyService.getStories();
      emit(state.copyWith(
        stories: stories,
        storiesStatus: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        storiesStatus: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGetHomeWidgets(
    GetHomeWidgetsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(homeWidgetsStatus: FormzSubmissionStatus.inProgress));

    try {
      final homeWidgets = await _homeWidgetService.getHomeWidgets();
      emit(state.copyWith(
        homeWidgets: homeWidgets,
        homeWidgetsStatus: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        homeWidgetsStatus: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}