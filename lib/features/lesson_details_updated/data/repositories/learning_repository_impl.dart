import 'package:intello_new/features/lesson_details_updated/domain/entities/activity.dart';
import 'package:intello_new/features/lesson_details_updated/domain/entities/lesson.dart';

import '../../domain/entities/level.dart';
import '../../domain/repositories/learning_repository.dart';
import '../datasources/learning_local_datasource.dart';

class LearningRepositoryImpl implements LearningRepository {
  final LearningLocalDataSource localDataSource;

  LearningRepositoryImpl(this.localDataSource);

  @override
  Future<List<Level>> getLevels() {
    return localDataSource.getLevels();
  }

  // @override
  // Future<List<Lesson>> getLessons() {
  //   return localDataSource.getLesson();
  // }
  @override
  Future<Lesson> getLessons({
    required String levelId,
    required String subjectId,
    required String lessonId,
  }) {
    return localDataSource.getLesson(
      levelId: levelId,
      subjectId: subjectId,
      lessonId: lessonId,
    );
  }

  @override
  Future<List<Activity>> getActivities({
    required String levelId,
    required String subjectId,
    required String lessonId,
  }) {
    return localDataSource.getActivities(
      levelId: levelId,
      subjectId: subjectId,
      lessonId: lessonId,
    );
  }
}
