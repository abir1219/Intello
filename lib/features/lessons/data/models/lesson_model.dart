import '../../domain/entities/lesson.dart';
import 'instruction_model.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.grade,
    required super.subject,
    required super.lessonNumber,
    required super.title,
    required super.description,
    required super.content,
    required InstructionModel super.instructions,
    super.lirePlus,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      grade: json['grade'],
      subject: json['subject'],
      lessonNumber: json['lesson_number'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      instructions: InstructionModel.fromJson(json['instructions']),
      // ✅ SAFE NULL HANDLING
      lirePlus: json['lire_plus'] != null
          ? LirePlusModel.fromJson(json['lire_plus'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'grade': grade,
      'subject': subject,
      'lesson_number': lessonNumber,
      'title': title,
      'description': description,
      'content': content,
      'instructions': {'fr': instructions.fr, 'moore': instructions.moore},
      // ✅ FIXED SERIALIZATION
      'lire_plus': lirePlus != null
          ? (lirePlus as LirePlusModel).toJson()
          : null,
    };
  }
}
