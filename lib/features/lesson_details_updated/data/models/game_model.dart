import '../../domain/entities/activity.dart';
import '../../domain/entities/game.dart';

class GameModel extends Game {
  const GameModel({
    required super.type,
    required super.instruction,
    super.pairs,
    super.items,
    super.correctOrder,
    required super.isAttended,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      type: json['type'],
      instruction: json['instruction'],
      isAttended: json['isAttended'] ?? false,

      pairs: json['pairs'] != null
          ? (json['pairs'] as List)
          .map((e) => MatchPair(
        left: e['left'],
        right: e['right'],
      ))
          .toList()
          : null,

      items: json['items'] != null
          ? List<String>.from(json['items'])
          : null,

      correctOrder: json['correct_order'] != null
          ? List<String>.from(json['correct_order'])
          : null,
    );
  }
}

/*
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
}*/
