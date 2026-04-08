import '../../domain/entities/activity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required super.type,
    required super.question,
    super.choices,
    super.answer,
    required super.isAttended,
    super.pairs,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      type: json['type'],
      question: json['question'],
      isAttended: json['isAttended'] ?? false,

      // Multiple choice
      choices: json['choices'] != null
          ? List<String>.from(json['choices'])
          : null,

      // Handle answer types dynamically
      answer: _parseAnswer(json),

      // Matching pairs
      pairs: json['pairs'] != null
          ? (json['pairs'] as List)
          .map((e) => MatchPair(
        left: e['left'],
        right: e['right'],
      ))
          .toList()
          : null,
    );
  }

  static dynamic _parseAnswer(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'multiple_choice':
        return json['correct_answer'];

      case 'true_false':
      case 'fill_blank':
        return json['answer'];

      case 'short_answer':
        return null;

      case 'matching':
        return null;

      default:
        return json['answer'];
    }
  }
}