import 'package:intello_new/features/lesson_details_updated/domain/entities/lesson.dart';
import 'package:intello_new/features/lesson_details_updated/domain/repositories/learning_repository.dart' show LearningRepository;

class GetLessons {
  final LearningRepository repository;

  GetLessons(this.repository);

  Future<Lesson> call({
    required String levelId,
    required String subjectId,
    required String lessonId,
  }) async {
    return await repository.getLessons(
      levelId: levelId,
      subjectId: subjectId,
      lessonId: lessonId,
    );
  }
}