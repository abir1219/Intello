import 'package:equatable/equatable.dart';
import 'subject.dart';

class Level extends Equatable {
  final String levelCode;
  final List<Subject> subjects;

  const Level({
    required this.levelCode,
    required this.subjects,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      levelCode: json['level_code'],
      subjects: (json['subjects'] as List)
          .map((e) => Subject.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [levelCode, subjects];
}