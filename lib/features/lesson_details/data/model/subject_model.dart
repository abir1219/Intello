
import 'package:intello_new/features/lesson_details/domain/entity/subject_entity.dart';

import 'lesson_content_model.dart';

class SubjectModel extends Subject {
  const SubjectModel({
    required super.subjectId,
    required super.lessons,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subjectId: json['subjectId'],
      lessons: (json['lessons'] as List)
          .map((e) => LessonContentModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "subjectId": subjectId,
      "lessons": lessons
          .map((e) => (e as LessonContentModel).toJson())
          .toList(),
    };
  }
}