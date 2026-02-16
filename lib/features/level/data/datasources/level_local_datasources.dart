import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/level_model.dart';

class LevelLocalDataSource {
  Future<List<LevelModel>> getLevels() async {
    final String response =
    await rootBundle.loadString('assets/json/levels.json');

    final List<dynamic> data = jsonDecode(response);

    return data.map((e) => LevelModel.fromJson(e)).toList();
  }
}
