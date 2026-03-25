import '../../domain/entities/activity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required super.type,
    required super.question,
    super.choices,
    super.answer,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      type: json['type'],
      question: json['question'],
      choices: json['choices'] != null
          ? List<String>.from(json['choices'])
          : null,
      answer: json['answer'] ?? json['correct_answer'],
    );
  }
}