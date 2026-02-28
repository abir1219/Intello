import '../../domain/entities/level.dart';
import 'subject_model.dart';

class LevelModel extends Level {
  const LevelModel({
    required super.levelCode,
    required List<SubjectModel> super.subjects,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      levelCode: json['level_code'],
      subjects: (json['subjects'] as List)
          .map(
            (e) =>
            SubjectModel.fromJson(
              e as Map<String, dynamic>,
            ),
      )
          .toList(),
    );
  }
}