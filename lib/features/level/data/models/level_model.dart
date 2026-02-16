
import '../../domain/entity/level_entity.dart';

class LevelModel extends LevelEntity {
  LevelModel({
    required super.id,
    required super.code,
    required super.title,
    required super.level,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      code: json['code'],
      title: json['title'],
      level: json['level'],
    );
  }
}
