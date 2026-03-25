import '../../domain/entities/subject.dart';
import 'lesson_model.dart';

class SubjectModel extends Subject {
  const SubjectModel({
    required super.subjectId,
    required super.lessons,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subjectId: json['subjectId'],
      lessons: (json['lessons'] as List)
          .map((e) => LessonModel.fromJson(e))
          .toList(),
    );
  }
}