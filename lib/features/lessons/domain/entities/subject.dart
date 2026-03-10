import 'package:equatable/equatable.dart';
import 'lesson.dart';

class Subject extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final List<Lesson> lessons;

  const Subject({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessons,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      lessons: (json['lessons'] as List)
          .map((e) => Lesson.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [id, title, subtitle, lessons];
}