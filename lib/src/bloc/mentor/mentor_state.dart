part of 'mentor_bloc.dart';

class MentorState extends Equatable {
  final FormzSubmissionStatus mentorsStatus;
  final FormzSubmissionStatus actionStatus; // Like/Dislike uchun
  final List<MentorModel> mentors;
  final String errorMessage;

  const MentorState({
    this.mentorsStatus = FormzSubmissionStatus.initial,
    this.actionStatus = FormzSubmissionStatus.initial,
    this.mentors = const [],
    this.errorMessage = '',
  });

  MentorState copyWith({
    FormzSubmissionStatus? mentorsStatus,
    FormzSubmissionStatus? actionStatus,
    List<MentorModel>? mentors,
    String? errorMessage,
  }) {
    return MentorState(
      mentorsStatus: mentorsStatus ?? this.mentorsStatus,
      actionStatus: actionStatus ?? this.actionStatus,
      mentors: mentors ?? this.mentors,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        mentorsStatus,
        actionStatus,
        mentors,
        errorMessage,
      ];
}