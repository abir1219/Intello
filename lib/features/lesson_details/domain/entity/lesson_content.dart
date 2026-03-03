import 'package:equatable/equatable.dart';
import 'package:intello_new/features/lesson_details/domain/entity/question.dart';

import 'exercise.dart';
import 'lecture.dart';

class LessonContent extends Equatable {
  final String levelId;
  final String subjectId;
  final String lessonId;
  final Exercise exercise;
  final Lecture lecture;

  LessonContent copyWith({
    List<Question>? exerciseQuestions,
  }) {
    return LessonContent(
      levelId: levelId,
      subjectId: subjectId,
      lessonId: lessonId,
      exercise: Exercise(
        questions: exerciseQuestions ?? exercise.questions,
      ),
      lecture: lecture,
    );
  }

  const LessonContent({
    required this.levelId,
    required this.subjectId,
    required this.lessonId,
    required this.exercise,
    required this.lecture,
  });

  @override
  List<Object> get props =>
      [levelId, subjectId, lessonId, exercise, lecture];
}