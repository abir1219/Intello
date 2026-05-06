import '../../domain/entities/activity.dart';
import '../../domain/entities/game.dart';

class GameModel extends Game {

  const GameModel({
    required super.type,
    required super.instruction,
    required super.isAttended,

    super.pairs,

    super.items,
    super.correctOrder,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {

    return GameModel(

      /// COMMON
      type: json['type'] ?? '',

      instruction: json['instruction'] ?? '',

      isAttended: json['isAttended'] ?? false,

      /// MATCHING
      pairs: (json['pairs'] as List?)
          ?.map(
            (e) => MatchingPair.fromJson(e),
      )
          .toList() ??
          [],

      /// ORDERING
      items: List<String>.from(
        json['items'] ?? [],
      ),

      correctOrder: List<String>.from(
        json['correct_order'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'type': type,

      'instruction': instruction,

      'isAttended': isAttended,

      /// MATCHING
      'pairs': pairs
          .map(
            (e) => e.toJson(),
      )
          .toList(),

      /// ORDERING
      'items': items,

      'correct_order': correctOrder,
    };
  }
}

/*class GameModel extends Game {
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
}*/

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
