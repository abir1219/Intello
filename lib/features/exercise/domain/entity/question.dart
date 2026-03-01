import 'package:equatable/equatable.dart';
import 'option.dart';

class Question extends Equatable {
  final String questionId;
  final String question;
  final List<Option> options;
  final String correctAnswerId;
  final String? selectedAnswerId;
  final bool isAttended;

  const Question({
    required this.questionId,
    required this.question,
    required this.options,
    required this.correctAnswerId,
    required this.selectedAnswerId,
    required this.isAttended,
  });

  @override
  List<Object?> get props => [
    questionId,
    question,
    options,
    correctAnswerId,
    selectedAnswerId,
    isAttended
  ];
}