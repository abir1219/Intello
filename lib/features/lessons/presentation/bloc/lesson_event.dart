part of 'lesson_bloc.dart';

sealed class LessonEvent extends Equatable {
  const LessonEvent();
}
class LoadLessonsEvent extends LessonEvent {
  final String levelCode;
  final String subject;

  const LoadLessonsEvent(this.subject, this.levelCode);
  @override
  List<Object?> get props => [subject,levelCode];
}
