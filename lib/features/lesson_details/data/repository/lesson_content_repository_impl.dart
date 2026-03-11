import 'package:flutter/foundation.dart';

import '../../domain/entity/lesson_content.dart';
import '../../domain/repository/lesson_content_repository.dart';
import '../datasource/lesson_content_local_datasource.dart';
import '../model/lesson_content_model.dart';

class LessonContentRepositoryImpl implements LessonContentRepository {
  final LessonContentLocalDataSource dataSource;

  LessonContentRepositoryImpl(this.dataSource);

  @override
  Future<LessonContent?> getLessonContent(
      String levelId,
      String subjectId,
      String lessonId,
      ) async {
    final data = await dataSource.loadLessons();

    /// Find Level
    final level = data.firstWhere(
          (e) => e['levelId'] == levelId,
      orElse: () => null,
    );

    if (level == null) return null;

    /// Find Subject
    final subject = (level['subjects'] as List).firstWhere(
          (e) => e['subjectId'] == subjectId,
      orElse: () => null,
    );

    if (subject == null) return null;

    /// Find Lesson
    final lesson = (subject['lessons'] as List).firstWhere(
          (e) => e['lessonId'] == lessonId,
      orElse: () => null,
    );

    if (lesson == null) return null;

    debugPrint("lesson: $lesson");

    /// Convert to Model
    return LessonContentModel.fromJson({
      "levelId": levelId,
      "subjectId": subjectId,
      ...lesson,
    });
  }
}