import 'package:intello_new/features/lesson_details_updated/domain/entities/activity.dart';
import 'package:intello_new/features/lesson_details_updated/domain/entities/lesson.dart';

import '../entities/level.dart';

abstract class LearningRepository {
  Future<List<Level>> getLevels();
  // Future<List<Lesson>> getLessons();
// ✅ Add filter params
  Future<Lesson> getLessons({
    required String levelId,
    required String subjectId,
  required String lessonId,
  });

  Future<List<Activity>> getActivities({
    required String levelId,
    required String subjectId,
    required String lessonId,
  });
}