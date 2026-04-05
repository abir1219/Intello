import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String type;
  final String question;
  final List<String>? choices;
  final dynamic answer;
  final dynamic isAttended;

  const Activity({
    required this.type,
    required this.question,
    this.choices,
    this.answer,
    this.isAttended,
  });

  @override
  List<Object?> get props => [type, question, choices, answer,isAttended];
}