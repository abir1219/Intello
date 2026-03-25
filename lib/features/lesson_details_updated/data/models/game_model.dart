import '../../domain/entities/game.dart';

class GameModel extends Game {
  const GameModel({
    required super.type,
    required super.instruction,
    super.data,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      type: json['type'],
      instruction: json['instruction'],
      data: json,
    );
  }
}