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

    final lesson = data.firstWhere(
          (e) =>
      e['levelId'] == levelId &&
          e['subjectId'] == subjectId &&
          e['lessonId'] == lessonId,
      orElse: () => null,
    );

    if (lesson == null) return null;

    return LessonContentModel.fromJson(lesson);
  }
}