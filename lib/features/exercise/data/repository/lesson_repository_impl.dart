import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intello_new/features/exercise/domain/repository/lesson_repository.dart';

import '../../domain/entity/lesson_content.dart';
import '../model/lesson_content_model.dart';

class LessonRepositoryImpl implements LessonRepository {

  Future<List<dynamic>> _loadJson() async {
    final response =
    await rootBundle.loadString('assets/json/lesson_content.json');
    return json.decode(response);
  }

  @override
  Future<LessonContent?> getLessonContent(
      String levelId,
      String subjectId,
      String lessonId,
      ) async {

    final data = await _loadJson();

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