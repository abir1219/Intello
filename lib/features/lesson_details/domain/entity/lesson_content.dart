import 'package:equatable/equatable.dart';
import 'exercise.dart';
import 'lecture.dart';
import 'question.dart';

class LessonContent extends Equatable {
  final String lessonId;
  final Exercise exercise;
  final Lecture lecture;

  const LessonContent({
    required this.lessonId,
    required this.exercise,
    required this.lecture,
  });

  LessonContent copyWith({
    List<Question>? exerciseQuestions,
  }) {
    return LessonContent(
      lessonId: lessonId,
      exercise: Exercise(
        questions: exerciseQuestions ?? exercise.questions,
      ),
      lecture: lecture,
    );
  }

  @override
  List<Object> get props => [
    lessonId,
    exercise,
    lecture,
  ];
}