part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

// Storylarni yuklash eventi
class GetStoriesEvent extends HomeEvent {}

// Home widgetlarni yuklash eventi
class GetHomeWidgetsEvent extends HomeEvent {}
