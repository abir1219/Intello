import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String type;
  final String? question;
  final String? instruction;

  final List<String>? choices;
  final dynamic answer;

  final bool isAttended;

  final List<MatchPair>? pairs;
  final List<String>? items;
  final List<String>? correctOrder;

  final String? sampleAnswer;
  final String? validation;
  final String? explanation;

  const Activity({
    required this.type,
    this.question,
    this.instruction,
    this.choices,
    this.answer,
    required this.isAttended,
    this.pairs,
    this.items,
    this.correctOrder,
    this.sampleAnswer,
    this.validation,
    this.explanation,
  });

  @override
  List<Object?> get props => [
    type,
    question,
    instruction,
    choices,
    answer,
    isAttended,
    pairs,
    items,
    correctOrder,
    sampleAnswer,
    validation,
    explanation,
  ];
}

/*class Activity extends Equatable {
  final String type;
  final String question;
  final List<String>? choices;
  final dynamic answer;
  final bool isAttended;
  final List<MatchPair>? pairs;

  const Activity({
    required this.type,
    required this.question,
    this.choices,
    this.answer,
    required this.isAttended,
    this.pairs,
  });

  @override
  List<Object?> get props => [
    type,
    question,
    choices,
    answer,
    isAttended,
    pairs,
  ];
}*/

class MatchPair extends Equatable {
  final String left;
  final String right;

  const MatchPair({
    required this.left,
    required this.right,
  });

  @override
  List<Object?> get props => [left, right];
}