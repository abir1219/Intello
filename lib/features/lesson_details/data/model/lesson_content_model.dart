
import '../../domain/entity/lesson_content.dart';
import 'exercise_model.dart';
import 'lecture_model.dart';

class LessonContentModel extends LessonContent {
  const LessonContentModel({
    required super.lessonId,
    required ExerciseModel super.exercise,
    required LectureModel super.lecture,
  });

  factory LessonContentModel.fromJson(Map<String, dynamic> json) {
    return LessonContentModel(
      lessonId: json['lessonId'],
      exercise: ExerciseModel.fromJson(json['exercise']),
      lecture: LectureModel.fromJson(json['lecture']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lessonId": lessonId,
      "exercise": (exercise as ExerciseModel).toJson(),
      "lecture": (lecture as LectureModel).toJson(),
    };
  }
}