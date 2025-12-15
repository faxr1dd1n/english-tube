part of 'mentor_bloc.dart';

@immutable
sealed class MentorEvent {}

// Mentorlarni yuklash eventi
class GetMentorsEvent extends MentorEvent {}

// Video like/dislike eventlari
class ToggleLikeEvent extends MentorEvent {
  final String userId;
  final int mentorId;
  final int videoId;

  ToggleLikeEvent({
    required this.userId,
    required this.mentorId,
    required this.videoId,
  });
}

class ToggleDislikeEvent extends MentorEvent {
  final String userId;
  final int mentorId;
  final int videoId;

  ToggleDislikeEvent({
    required this.userId,
    required this.mentorId,
    required this.videoId,
  });
}