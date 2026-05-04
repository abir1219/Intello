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
