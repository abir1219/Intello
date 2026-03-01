part of 'lesson_content_bloc.dart';

sealed class LessonContentState extends Equatable {
  const LessonContentState();
}

final class LessonContentInitial extends LessonContentState {
  @override
  List<Object> get props => [];
}

class LessonLoading extends LessonContentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LessonLoaded extends LessonContentState {
  final LessonContent lesson;
  final double exercisePercentage;

  const LessonLoaded({
    required this.lesson,
    required this.exercisePercentage,
  });

  @override
  List<Object?> get props => [lesson, exercisePercentage];
}

class LessonError extends LessonContentState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object?> get props => [message];
}
