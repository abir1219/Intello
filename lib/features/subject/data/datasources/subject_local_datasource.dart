import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/subject_model.dart';

class SubjectLocalDataSource {

  Future<List<SubjectModel>> getSubjectsByLevel(
      String levelCode) async {

    final response = await rootBundle
        .loadString('assets/json/subjects.json');

    final Map<String, dynamic> data =
    jsonDecode(response);

    final List levels = data['levels'];

    final level = levels.firstWhere(
          (e) => e['level_code'] == levelCode,
      orElse: () => null,
    );

    if (level == null) return [];

    final subjects = level['subjects'] as List;

    return subjects
        .map((e) => SubjectModel.fromJson(e))
        .toList();
  }
}