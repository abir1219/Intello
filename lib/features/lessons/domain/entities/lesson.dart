import 'package:equatable/equatable.dart';


class Lesson extends Equatable {
  final String id;
  final String grade;
  final String subject;
  final int lessonNumber;
  final String title;
  final Instruction instructions;

  const Lesson({
    required this.id,
    required this.grade,
    required this.subject,
    required this.lessonNumber,
    required this.title,
    required this.instructions,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      grade: json['grade'],
      subject: json['subject'],
      lessonNumber: json['lesson_number'],
      title: json['title'],
      instructions: Instruction.fromJson(json['instructions']),
    );
  }

  @override
  List<Object> get props =>
      [
        id,
        grade,
        subject,
        lessonNumber,
        title,
        instructions,
      ];
}


class Instruction extends Equatable {
  final String fr;
  final String moore;

  const Instruction({
    required this.fr,
    required this.moore,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      fr: json['fr'],
      moore: json['moore'],
    );
  }

  @override
  List<Object> get props => [fr, moore];
}