import 'dart:convert';
import 'package:flutter/services.dart';

abstract class LessonContentLocalDataSource {
  Future<List<dynamic>> loadLessons();
}

class LessonContentLocalDataSourceImpl implements LessonContentLocalDataSource {

  @override
  Future<List<dynamic>> loadLessons() async {
    final response =
    await rootBundle.loadString('assets/json/lesson_content.json');
    return json.decode(response) as List;
  }
}