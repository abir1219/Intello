import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/lesson_model.dart';

abstract class LessonLocalDataSource {
  Future<List<LessonModel>> getEmcLessons(String subjectId, String levelId);
}

class SubjectLocalDataSourceImpl implements LessonLocalDataSource {
  Future<List<dynamic>> _loadJson() async {
    final String response = await rootBundle.loadString(
      'assets/json/lessons.json',
    );
    return json.decode(response) as List;
  }

  @override
  Future<List<LessonModel>> getEmcLessons(
    String subjectId,
    String levelId,
  ) async {
    debugPrint("SubjectId->$subjectId and levelId->$levelId");
    final data = await _loadJson();

    // 🔹 1️⃣ Find the correct level
    final level = data.firstWhere(
      (l) => l['level_code'] == levelId,
      orElse: () => null,
    );

    if (level == null || level['subjects'] is! List) {
      return [];
    }

    final subjects = level['subjects'] as List;

    // 🔹 2️⃣ Find the correct subject
    final subject = subjects.firstWhere(
      (s) => s['id'] == subjectId,
      orElse: () => null,
    );

    if (subject == null || subject['lessons'] is! List) {
      return [];
    }

    debugPrint(
      "RESULT:${(subject['lessons'] as List).map<LessonModel>((e) => LessonModel.fromJson(e as Map<String, dynamic>)).toList()}",
    );
    // 🔹 3️⃣ Return lessons
    return (subject['lessons'] as List)
        .map<LessonModel>(
          (e) => LessonModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
