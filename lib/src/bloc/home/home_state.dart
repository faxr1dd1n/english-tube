part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<StoryData> stories;
  final List<HomeWidgetModel> homeWidgets;
  final FormzSubmissionStatus storiesStatus;
  final FormzSubmissionStatus homeWidgetsStatus;
  final String errorMessage;

  const HomeState({
    this.stories = const [],
    this.homeWidgets = const [],
    this.storiesStatus = FormzSubmissionStatus.initial,
    this.homeWidgetsStatus = FormzSubmissionStatus.initial,
    this.errorMessage = '',
  });

  HomeState copyWith({
    List<StoryData>? stories,
    List<HomeWidgetModel>? homeWidgets,
    FormzSubmissionStatus? storiesStatus,
    FormzSubmissionStatus? homeWidgetsStatus,
    String? errorMessage,
  }) {
    return HomeState(
      stories: stories ?? this.stories,
      homeWidgets: homeWidgets ?? this.homeWidgets,
      storiesStatus: storiesStatus ?? this.storiesStatus,
      homeWidgetsStatus: homeWidgetsStatus ?? this.homeWidgetsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        stories,
        homeWidgets,
        storiesStatus,
        homeWidgetsStatus,
        errorMessage,
      ];
}