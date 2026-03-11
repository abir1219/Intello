import 'package:equatable/equatable.dart';
import 'package:intello_new/features/lesson_details/domain/entity/subject_entity.dart';


class Level extends Equatable {
  final String levelId;
  final List<Subject> subjects;

  const Level({
    required this.levelId,
    required this.subjects,
  });

  @override
  List<Object> get props => [levelId, subjects];
}