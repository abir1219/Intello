import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intello_new/features/lesson_details_updated/domain/entities/lesson.dart';
import 'package:intello_new/features/lesson_details_updated/domain/usecases/get_lessons.dart';

part 'learning_event.dart';
part 'learning_state.dart';

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  // final GetActivities getActivities;
  final GetLessons getLessons;

  LearningBloc(this.getLessons) : super(LearningInitial()) {

    on<LoadLessonEvent>((event, emit) async {
      emit(LearningLoading());

      try {
        /*final activities = await getActivities(
          levelId: event.levelId,
          subjectId: event.subjectId,
          lessonId: event.lessonId,
        );*/

        final lessons = await getLessons(
          levelId: event.levelId,
          subjectId: event.subjectId,
          lessonId: event.lessonId,
        );


        // debugPrint("ACTIVITIES_BLOC: $activities");
        debugPrint("LESSONS_BLOC: $lessons");

        // ✅ Directly use activities
        // final percentage = _calculateExercisePercentage(activities);
        //final percentage = _calculateExercisePercentage(lessons);

        emit(LearningLoaded(
          // activity: activities,
          lessons: lessons,
          exercisePercentage: 0,
        ));

      } catch (e) {
        emit(LearningError(e.toString()));
        debugPrint("ACTIVITIES_ERROR: $e");
      }
    });
  }

  // double _calculateExercisePercentage(List<Activity> activities) {
  /*double _calculateExercisePercentage(Lesson lessons) {
    if (lessons.isEmpty) return 0;

    final attended =
        lessons.where((q) => q.isAttended == true).length;

    return (attended / lessons.length) * 100;
  }*/
}
