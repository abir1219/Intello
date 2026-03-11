import 'package:equatable/equatable.dart';

import 'lesson_content.dart';


class Subject extends Equatable {
  final String subjectId;
  final List<LessonContent> lessons;

  const Subject({
    required this.subjectId,
    required this.lessons,
  });

  @override
  List<Object> get props => [subjectId, lessons];
}