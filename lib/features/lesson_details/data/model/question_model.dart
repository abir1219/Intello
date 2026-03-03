
import '../../domain/entity/question.dart';
import 'option_model.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.questionId,
    required super.question,
    required List<OptionModel> super.options,
    required super.correctAnswerId,
    required super.selectedAnswerId,
    required super.isAttended,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      questionId: json['questionId'],
      question: json['question'],
      options: (json['options'] as List)
          .map((e) => OptionModel.fromJson(e))
          .toList(),
      correctAnswerId: json['correctAnswerId'],
      selectedAnswerId: json['selectedAnswerId'],
      isAttended: json['isAttended'],
    );
  }
}