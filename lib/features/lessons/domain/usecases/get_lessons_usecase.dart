import 'package:intello_new/features/lessons/domain/entities/lesson.dart';
import '../../data/models/lesson_model.dart';
import '../repositories/subject_repository.dart';

class GetLessonsUseCase {
  final LessonRepository repository;
  GetLessonsUseCase(this.repository);

  Future<List<Lesson>> call(String subjectId,String levelCode) async {
    return await repository.getEmcLessons(subjectId,levelCode);
  }
}