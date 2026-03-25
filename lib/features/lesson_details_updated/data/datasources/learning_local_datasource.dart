import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/level_model.dart';

abstract class LearningLocalDataSource {
  Future<List<LevelModel>> getLevels();
}

class LearningLocalDataSourceImpl implements LearningLocalDataSource {
  @override
  Future<List<LevelModel>> getLevels() async {
    final jsonString =
    await rootBundle.loadString('assets/json/learning.json');

    final data = json.decode(jsonString) as List;

    return data.map((e) => LevelModel.fromJson(e)).toList();
  }
}