import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final String id;
  final String grade;
  final String subject;
  final int lessonNumber;
  final String title;
  final String? description;
  final String? content;
  final Instruction instructions;
  final LirePlus? lirePlus;

  const Lesson({
    required this.id,
    required this.grade,
    required this.subject,
    required this.lessonNumber,
    required this.title,
    this.description,
    this.content,
    required this.instructions,
    this.lirePlus,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      grade: json['grade'],
      subject: json['subject'],
      lessonNumber: json['lesson_number'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      instructions: Instruction.fromJson(json['instructions']),
      lirePlus: LirePlus.fromJson(json['lire_plus']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    grade,
    subject,
    lessonNumber,
    title,
    description,
    content,
    instructions,
    lirePlus,
  ];
}

class LirePlus extends Equatable {
  final bool enabled;
  final String buttonLabel;
  final String extendedContent;

  const LirePlus({
    required this.enabled,
    required this.buttonLabel,
    required this.extendedContent,
  });

  factory LirePlus.fromJson(Map<String, dynamic> json) {
    return LirePlus(
      enabled: json['enabled'],
      buttonLabel: json['button_label'],
      extendedContent: json['extended_content'],
    );
  }

  @override
  List<Object?> get props => [enabled, buttonLabel, extendedContent];
}

class Instruction extends Equatable {
  final String fr;
  final String moore;

  const Instruction({required this.fr, required this.moore});

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(fr: json['fr'], moore: json['moore']);
  }

  @override
  List<Object> get props => [fr, moore];
}
