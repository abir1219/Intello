import '../entity/lesson_content.dart';

abstract class LessonRepository {
  Future<LessonContent?> getLessonContent(
    String levelId,
    String subjectId,
    String lessonId,
  );
}
