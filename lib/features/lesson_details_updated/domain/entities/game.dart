import 'package:equatable/equatable.dart';


class Game extends Equatable {

  /// COMMON
  final String type;
  final String instruction;
  final bool isAttended;

  /// MATCHING
  final List<MatchingPair> pairs;

  /// ORDERING
  final List<String> items;
  final List<String> correctOrder;

  const Game({
    required this.type,
    required this.instruction,
    required this.isAttended,

    this.pairs = const [],

    this.items = const [],
    this.correctOrder = const [],
  });

  factory Game.fromJson(Map<String, dynamic> json) {

    return Game(

      type: json['type'] ?? '',

      instruction: json['instruction'] ?? '',

      isAttended: json['isAttended'] ?? false,

      /// MATCHING
      pairs: (json['pairs'] as List?)
          ?.map((e) => MatchingPair.fromJson(e))
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
          .map((e) => e.toJson())
          .toList(),

      /// ORDERING
      'items': items,

      'correct_order': correctOrder,
    };
  }

  @override
  List<Object?> get props => [

    type,
    instruction,
    isAttended,

    pairs,

    items,
    correctOrder,
  ];
}

class MatchingPair extends Equatable {

  final String left;
  final String right;

  const MatchingPair({
    required this.left,
    required this.right,
  });

  factory MatchingPair.fromJson(Map<String, dynamic> json) {

    return MatchingPair(

      left: json['left'] ?? '',

      right: json['right'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'left': left,

      'right': right,
    };
  }

  @override
  List<Object?> get props => [
    left,
    right,
  ];
}
/*
import 'package:equatable/equatable.dart';

import 'activity.dart';

class Game extends Equatable {
  final String type;
  final String instruction;

  final List<MatchPair>? pairs;
  final List<String>? items;
  final List<String>? correctOrder;

  final bool isAttended;

  const Game({
    required this.type,
    required this.instruction,
    this.pairs,
    this.items,
    this.correctOrder,
    required this.isAttended,
  });

  @override
  List<Object?> get props => [
    type,
    instruction,
    pairs,
    items,
    correctOrder,
    isAttended,
  ];
}

*/
/*
class Game extends Equatable {
  final String type;
  final String instruction;
  final dynamic data;

  const Game({
    required this.type,
    required this.instruction,
    this.data,
  });

  @override
  List<Object?> get props => [type, instruction, data];
}*/
