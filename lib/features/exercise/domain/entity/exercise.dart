import 'package:equatable/equatable.dart';
import 'question.dart';

class Exercise extends Equatable {
  final List<Question> questions;

  const Exercise({required this.questions});

  @override
  List<Object> get props => [questions];
}