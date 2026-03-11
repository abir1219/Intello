
import 'package:intello_new/features/lesson_details/data/model/question_model.dart';

import '../../domain/entity/exercise.dart';

class ExerciseModel extends Exercise {
  const ExerciseModel({
    required super.questions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      questions: (json['questions'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "questions": questions
          .map((e) => (e as QuestionModel).toJson())
          .toList(),
    };
  }
}