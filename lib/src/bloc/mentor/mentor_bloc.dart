import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:en_tube/src/model/mentor_model.dart';
import 'package:en_tube/src/service/firestore_mentor_service.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'mentor_event.dart';
part 'mentor_state.dart';

class MentorBloc extends Bloc<MentorEvent, MentorState> {
  final FirestoreMentorService _mentorService;
  StreamSubscription<List<MentorModel>>? _mentorSubscription;

  MentorBloc({FirestoreMentorService? mentorService})
      : _mentorService = mentorService ?? FirestoreMentorService(),
        super(const MentorState()) {

    // Mentorlarni yuklash
    on<GetMentorsEvent>(_onGetMentors);

    // Like toggle
    on<ToggleLikeEvent>(_onToggleLike);

    // Dislike toggle
    on<ToggleDislikeEvent>(_onToggleDislike);

    // Internal eventlar
    on<_UpdateMentorsEvent>(_onUpdateMentors);
    on<_MentorsErrorEvent>(_onMentorsError);
  }

  // Mentorlarni yangilash
  void _onUpdateMentors(
    _UpdateMentorsEvent event,
    Emitter<MentorState> emit,
  ) {
    
    emit(state.copyWith(
      mentors: event.mentors,
      mentorsStatus: FormzSubmissionStatus.success,
    ));
  }

  // Xatolikni qayta ishlash
  void _onMentorsError(
    _MentorsErrorEvent event,
    Emitter<MentorState> emit,
  ) {
    emit(state.copyWith(
      mentorsStatus: FormzSubmissionStatus.failure,
      errorMessage: event.error,
    ));
  }

  // Mentorlarni stream orqali yuklash
  Future<void> _onGetMentors(
    GetMentorsEvent event,
    Emitter<MentorState> emit,
  ) async {
    emit(state.copyWith(mentorsStatus: FormzSubmissionStatus.inProgress));

    await _mentorSubscription?.cancel();

    _mentorSubscription = _mentorService.getMetorsStream().listen(
      (mentors) {
        add(_UpdateMentorsEvent(mentors));
      },
      onError: (error) {
        add(_MentorsErrorEvent(error.toString()));
      },
    );
  }

  // Like toggle
  Future<void> _onToggleLike(
    ToggleLikeEvent event,
    Emitter<MentorState> emit,
  ) async {
    emit(state.copyWith(actionStatus: FormzSubmissionStatus.inProgress));
    
    try {
      await _mentorService.toggleLike(
        userId: event.userId,
        mentorId: event.mentorId,
        videoId: event.videoId,
      );
      emit(state.copyWith(actionStatus: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        actionStatus: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  // Dislike toggle
  Future<void> _onToggleDislike(
    ToggleDislikeEvent event,
    Emitter<MentorState> emit,
  ) async {
    emit(state.copyWith(actionStatus: FormzSubmissionStatus.inProgress));
    
    try {
      await _mentorService.toggleDislike(
        userId: event.userId,
        mentorId: event.mentorId,
        videoId: event.videoId,
      );
      emit(state.copyWith(actionStatus: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        actionStatus: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _mentorSubscription?.cancel();
    return super.close();
  }
}

// Internal eventlar - faqat bloc ichida ishlatiladi
class _UpdateMentorsEvent extends MentorEvent {
  final List<MentorModel> mentors;
  _UpdateMentorsEvent(this.mentors);
}

class _MentorsErrorEvent extends MentorEvent {
  final String error;
  _MentorsErrorEvent(this.error);


}