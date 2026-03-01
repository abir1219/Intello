
import '../../domain/entity/lesson_content.dart';
import 'exercise_model.dart';
import 'lecture_model.dart';

class LessonContentModel extends LessonContent {
  const LessonContentModel({
    required super.levelId,
    required super.subjectId,
    required super.lessonId,
    required ExerciseModel super.exercise,
    required LectureModel super.lecture,
  });

  factory LessonContentModel.fromJson(Map<String, dynamic> json) {
    return LessonContentModel(
      levelId: json['levelId'],
      subjectId: json['subjectId'],
      lessonId: json['lessonId'],
      exercise: ExerciseModel.fromJson(json['exercise']),
      lecture: LectureModel.fromJson(json['lecture']),
    );
  }
}