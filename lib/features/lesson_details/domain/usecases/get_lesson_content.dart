import 'package:intello_new/features/lesson_details/domain/repository/lesson_content_repository.dart';

import '../entity/lesson_content.dart';

class GetLessonContent {
  final LessonContentRepository repository;

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