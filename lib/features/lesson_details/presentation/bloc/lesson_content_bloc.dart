import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entity/lesson_content.dart';
import '../../domain/entity/question.dart';
import '../../domain/usecases/get_lesson_content.dart';

part 'lesson_content_event.dart';

part 'lesson_content_state.dart';

class LessonContentBloc extends Bloc<LessonContentEvent, LessonContentState> {
  final GetLessonContent getLessonContent;

  LessonContentBloc(this.getLessonContent) : super(LessonContentInitial()) {
    on<LoadLessonEvent>(_onLoadLesson);
    on<SelectAnswerEvent>(_onSelectAnswer);
  }

  LessonContent? _currentLesson;

  // 🔹 LOAD LESSON
  Future<void> _onLoadLesson(
    LoadLessonEvent event,
    Emitter<LessonContentState> emit,
  ) async {
    emit(LessonLoading());
    debugPrint("start");
    debugPrint("LevelId-->${event.levelId}");
    debugPrint("SubjectId-->${event.subjectId}");
    debugPrint("LessonId-->${event.lessonId}");
    try {
      final lesson = await getLessonContent(
        event.levelId,
        event.subjectId,
        event.lessonId, //.toLowerCase(),
      );
      debugPrint("lesson--->${lesson.toString()}");

      if (lesson == null) {
        debugPrint("lessonError--->Lesson not found");
        emit(const LessonError("Lesson not found"));
        return;
      }

      _currentLesson = lesson;

      emit(
        LessonLoaded(
          lesson: lesson,
          exercisePercentage: _calculateExercisePercentage(
            lesson.exercise.questions,
          ),
        ),
      );
    } catch (e) {
      debugPrint("Catch-->${e.toString()}");
      emit(LessonError(e.toString()));
    }
  }

  // 🔹 SELECT ANSWER
  void _onSelectAnswer(
    SelectAnswerEvent event,
    Emitter<LessonContentState> emit,
  ) {
    if (_currentLesson == null) return;

    final updatedQuestions = _currentLesson!.exercise.questions.map((q) {
      if (q.questionId == event.questionId) {
        return Question(
          questionId: q.questionId,
          question: q.question,
          options: q.options,
          correctAnswerId: q.correctAnswerId,
          selectedAnswerId: event.selectedAnswerId,
          isAttended: true,
        );
      }

      return q;
    }).toList();

    final updatedLesson = _currentLesson!.copyWith(
      exerciseQuestions: updatedQuestions,
    );

    _currentLesson = updatedLesson;

    emit(
      LessonLoaded(
        lesson: updatedLesson,
        exercisePercentage: _calculateExercisePercentage(updatedQuestions),
      ),
    );
  }

  // 🔹 PERCENTAGE CALCULATION
  double _calculateExercisePercentage(List<Question> questions) {
    debugPrint("questions-->$questions");
    if (questions.isEmpty) return 0;

    final attended = questions.where((q) => q.isAttended == true).length;
    debugPrint("attended-->$attended");

    return (attended / questions.length) * 100;
  }
}
