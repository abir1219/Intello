import 'package:equatable/equatable.dart';
import 'activity.dart';
import 'game.dart';

class Lesson extends Equatable {
  final String lessonId;
  final List<Activity> activities;
  final List<Game> games;

  const Lesson({
    required this.lessonId,
    required this.activities,
    required this.games,
  });

  @override
  List<Object?> get props => [lessonId, activities, games];
}