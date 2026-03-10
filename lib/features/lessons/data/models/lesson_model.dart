import '../../domain/entities/lesson.dart';
import 'instruction_model.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.grade,
    required super.subject,
    required super.lessonNumber,
    required super.title,
    required InstructionModel super.instructions,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      grade: json['grade'],
      subject: json['subject'],
      lessonNumber: json['lesson_number'],
      title: json['title'],
      instructions: InstructionModel.fromJson(
        json['instructions'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grade': grade,
      'subject': subject,
      'lesson_number': lessonNumber,
      'title': title,
      'instructions': {
        'fr': instructions.fr,
        'moore': instructions.moore,
      }
    };
  }
}