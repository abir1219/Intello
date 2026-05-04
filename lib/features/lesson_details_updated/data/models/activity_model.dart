import '../../domain/entities/activity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    required super.type,
    super.question,
    super.instruction,
    super.choices,
    super.answer,
    required super.isAttended,
    super.pairs,
    super.items,
    super.correctOrder,
    super.sampleAnswer,
    super.validation,
    super.explanation,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      type: json['type'],

      question: json['question'],
      instruction: json['instruction'],

      isAttended: json['isAttended'] ?? false,
      explanation: json['explanation'],

      /// MCQ
      choices: json['choices'] != null
          ? List<String>.from(json['choices'])
          : null,

      /// Ordering
      items: json['items'] != null
          ? List<String>.from(json['items'])
          : null,

      correctOrder: json['correct_order'] != null
          ? List<String>.from(json['correct_order'])
          : null,

      /// Short/practical
      sampleAnswer: json['sample_answer'],
      validation: json['validation'],

      /// Matching
      pairs: json['pairs'] != null
          ? (json['pairs'] as List)
          .map((e) => MatchPair(
        left: e['left'],
        right: e['right'],
      ))
          .toList()
          : null,

      answer: _parseAnswer(json),
    );
  }

  static dynamic _parseAnswer(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'multiple_choice':
        return json['correct_answer'];

      case 'true_false':
        return _normalizeBool(json['answer']);

      case 'fill_blank':
        return json['answer'];

      case 'ordering':
        return json['correct_order'];

      case 'matching':
      case 'short_answer':
      case 'practical':
        return null;

      default:
        return json['answer'];
    }
  }

  static bool? _normalizeBool(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return null;
  }
}

/*
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
}*/
