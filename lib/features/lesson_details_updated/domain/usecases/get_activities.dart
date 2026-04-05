import 'package:intello_new/features/lesson_details_updated/domain/entities/activity.dart';
import 'package:intello_new/features/lesson_details_updated/domain/repositories/learning_repository.dart' show LearningRepository;

class GetActivities {
  final LearningRepository repository;

  GetActivities(this.repository);

  Future<List<Activity>> call({
    required String levelId,
    required String subjectId,
    required String lessonId,
  }) async {
    return await repository.getActivities(
      levelId: levelId,
      subjectId: subjectId,
      lessonId: lessonId,
    );
  }
}