import '../../domain/entities/level.dart';
import 'subject_model.dart';

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
}