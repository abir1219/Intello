import 'package:equatable/equatable.dart';
import 'subject.dart';

class Level extends Equatable {
  final String levelId;
  final List<Subject> subjects;

  const Level({
    required this.levelId,
    required this.subjects,
  });

  @override
  List<Object?> get props => [levelId, subjects];
}