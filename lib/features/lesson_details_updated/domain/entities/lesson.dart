import 'package:equatable/equatable.dart';
import '../../../lesson_details_updated/domain/entities/lecture.dart';
import 'activity.dart';
import 'game.dart';

class Lesson extends Equatable {
  final String lessonId;
  final List<Activity> activities;
  final List<Game> games;

  /// ❌ REMOVE lecture (not present in JSON)
  /// Keep optional if backend may add later

  const Lesson({
    required this.lessonId,
    required this.activities,
    required this.games,
  });

  @override
  List<Object?> get props => [
    lessonId,
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
