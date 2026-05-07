import 'package:equatable/equatable.dart';
import 'activity.dart';
import 'game.dart';

class Lesson extends Equatable {
  final String lessonId;
  final String lecture;
  final List<Activity> activities;
  final List<Game> games;

  const Lesson({
    required this.lessonId,
    required this.lecture,
    required this.activities,
    required this.games,
  });

  @override
  List<Object?> get props => [
    lessonId,
    lecture,
    activities,
    games,
  ];
}

/*class Lesson extends Equatable {
  final String lessonId;
  final List<Activity> activities;
  final List<Lecture> lecture;
  final List<Game> games;

  const Lesson({
    required this.lessonId,
    required this.activities,
    required this.games,
    required this.lecture,
  });

  @override
  List<Object?> get props => [lessonId, activities, games, lecture];
}*/
