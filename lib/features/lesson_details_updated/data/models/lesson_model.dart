import '../../domain/entities/lesson.dart';
import 'activity_model.dart';
import 'game_model.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.lessonId,
    required super.activities,
    required super.games,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      lessonId: json['lessonId'],
      activities: (json['activities'] as List)
          .map((e) => ActivityModel.fromJson(e))
          .toList(),
      games: (json['games'] as List)
          .map((e) => GameModel.fromJson(e))
          .toList(),
    );
  }
}