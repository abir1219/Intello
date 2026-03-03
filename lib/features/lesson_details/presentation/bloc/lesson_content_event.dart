part of 'lesson_content_bloc.dart';

sealed class LessonContentEvent extends Equatable {
  const LessonContentEvent();
}
class LoadLessonEvent extends LessonContentEvent {
  final String levelId;
  final String subjectId;
  final String lessonId;

  const LoadLessonEvent({
    required this.levelId,
    required this.subjectId,
    required this.lessonId,
  });

  @override
  List<Object?> get props => [levelId, subjectId, lessonId];
}

class SelectAnswerEvent extends LessonContentEvent {
  final String questionId;
  final String selectedAnswerId;

  const SelectAnswerEvent({
    required this.questionId,
    required this.selectedAnswerId,
  });

  @override
  List<Object?> get props => [questionId, selectedAnswerId];
}
