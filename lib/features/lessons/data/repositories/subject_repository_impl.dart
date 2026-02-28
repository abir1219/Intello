import '../../domain/entities/lesson.dart';
import '../../domain/repositories/subject_repository.dart';
import '../datasource/lesson_local_datasource.dart';
import '../models/lesson_model.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonLocalDataSource localDataSource;

  LessonRepositoryImpl(this.localDataSource);

  /*@override
  Future<LessonModel?> getLessons(String id) async {
    return await localDataSource.getSubjects(id);
  }*/

  @override
  Future<List<Lesson>> getEmcLessons(String subjectId,String levelCode) async {
    return await localDataSource.getEmcLessons(subjectId,levelCode);
  }
}