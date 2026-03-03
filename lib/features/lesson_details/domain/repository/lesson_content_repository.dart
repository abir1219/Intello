import '../entity/lesson_content.dart';

abstract class LessonContentRepository {
  Future<LessonContent?> getLessonContent(
    String levelId,
    String subjectId,
    String lessonId,
  );
}
