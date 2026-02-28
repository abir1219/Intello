import '../entities/lesson.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getEmcLessons(String subjectId,String levelCode);
}