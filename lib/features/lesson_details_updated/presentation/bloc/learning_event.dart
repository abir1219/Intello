part of 'learning_bloc.dart';

abstract class LearningEvent extends Equatable {}

class LoadLevelsEvent extends LearningEvent {
  @override
  List<Object?> get props => [];
}

class LoadLessonEvent extends LearningEvent {
  final String levelId;
  final String subjectId;
  final String lessonId;

   LoadLessonEvent({
    required this.levelId,
    required this.subjectId,
    required this.lessonId,
  });

  @override
  List<Object?> get props => [levelId, subjectId, lessonId];
}