

import 'package:intello_new/features/lesson_details/data/model/subject_model.dart';
import 'package:intello_new/features/lesson_details/domain/entity/level_entity.dart';

class LevelModel extends Level {
  const LevelModel({
    required super.levelId,
    required super.subjects,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      levelId: json['levelId'],
      subjects: (json['subjects'] as List)
          .map((e) => SubjectModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "levelId": levelId,
      "subjects": subjects
          .map((e) => (e as SubjectModel).toJson())
          .toList(),
    };
  }
}