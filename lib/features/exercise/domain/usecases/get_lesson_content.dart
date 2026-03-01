

import 'package:intello_new/features/exercise/domain/repository/lesson_repository.dart';

import '../entity/lesson_content.dart';

class GetLessonContent {
  final LessonRepository repository;

  GetLessonContent(this.repository);

  Future<LessonContent?> call(
      String levelId,
      String subjectId,
      String lessonId,
      ) async {
    return await repository.getLessonContent(
      levelId,
      subjectId,
      lessonId,
    );
  }
}