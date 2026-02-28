import 'package:equatable/equatable.dart';
import 'subject.dart';

class Level extends Equatable {
  final String levelCode;
  final List<Subject> subjects;

  const Level({
    required this.levelCode,
    required this.subjects,
  });

  @override
  List<Object> get props => [levelCode, subjects];
}