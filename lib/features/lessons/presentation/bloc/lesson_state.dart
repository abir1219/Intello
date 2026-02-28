part of 'lesson_bloc.dart';

sealed class LessonState extends Equatable {
  const LessonState();
}

final class LessonInitial extends LessonState {
  @override
  List<Object> get props => [];
}

class LessonLoading extends LessonState {
  @override
  List<Object?> get props => [];
}

class LessonLoaded extends LessonState {
  final List<Lesson> lessons;

  const LessonLoaded(this.lessons);

  @override
  List<Object?> get props => [lessons];
}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object?> get props => [message];
}
