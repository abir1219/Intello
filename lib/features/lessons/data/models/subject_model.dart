import '../../domain/entities/subject.dart';
import 'lesson_model.dart';

class SubjectModel extends Subject {
  const SubjectModel({
    required String id,
    required String title,
    required String subtitle,
    required List<LessonModel> lessons,
  }) : super(
    id: id,
    title: title,
    subtitle: subtitle,
    lessons: lessons,
  );

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      lessons: (json['lessons'] as List)
          .map(
            (e) => LessonModel.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}