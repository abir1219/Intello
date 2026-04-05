import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intello_new/features/lesson_details_updated/data/models/activity_model.dart' show ActivityModel;
import 'package:intello_new/features/lesson_details_updated/data/models/lesson_model.dart';
import 'package:intello_new/features/lesson_details_updated/domain/entities/activity.dart' show Activity;
import 'package:intello_new/features/lesson_details_updated/domain/entities/lesson.dart';
import '../models/level_model.dart';

abstract class LearningLocalDataSource {
  Future<List<LevelModel>> getLevels();

  Future<Lesson> getLesson({
    required String levelId,
    required String subjectId,
    required String lessonId,
  });

  Future<List<Activity>> getActivities({
    required String levelId,
    required String subjectId,
    required String lessonId,
  });
}

class LearningLocalDataSourceImpl implements LearningLocalDataSource {
  @override
  Future<List<LevelModel>> getLevels() async {
    // final jsonString =
    // await rootBundle.loadString('assets/json/json_content_updated.json');
    //
    // final data = json.decode(jsonString) as List;
    final data = await _loadJson();

    return data.map((e) => LevelModel.fromJson(e)).toList();
  }

  @override
  Future<Lesson> getLesson({
    required String levelId,
    required String subjectId,
    String? lessonId,
  }) async {
    final data = await _loadJson();

    // final List<Lesson> filteredLessons = [];
    late final lessonModel;

    for (var level in data) {
      if (level['levelId'] == levelId) {
        for (var subject in level['subjects']) {
          if (subject['subjectId'] == subjectId) {
            for (var lesson in subject['lessons']) {
              // ✅ If lessonId provided → filter


              if (lessonId != null) {
                if (lesson['id'] == lessonId) {
                  debugPrint("lesson--->${lesson['id']} and $lessonId");
                  debugPrint("lesson--->$lesson");
                  lessonModel = LessonModel.fromJson(lesson);
                  // filteredLessons.add(LessonModel.fromJson(lesson));
                }
              } else {
                // ✅ return all lessons of subject
                lessonModel = LessonModel.fromJson(lesson);
                // filteredLessons.add(LessonModel.fromJson(lesson));
              }
            }
          }
        }
      }
    }
    // debugPrint("filteredLessons-->${filteredLessons.length}");
    return lessonModel;//filteredLessons;
  }

  Future<List<dynamic>> _loadJson() async {
    final String response = await rootBundle.loadString(
      'assets/json/json_content_updated.json',
    );
    return json.decode(response) as List;
  }

  @override
  Future<List<Activity>> getActivities({
    required String levelId,
    required String subjectId,
    required String lessonId,
  }) async {
    final data = await _loadJson();
    debugPrint("ACTIVITIES_JSON: $data");

    final List<Activity> activities = [];

    for (var level in data) {
      if (level['levelId'] == levelId) {
        debugPrint("ACTIVITIES_LEVEL: $level");

        for (var subject in level['subjects']) {
          if (subject['subjectId'] == subjectId) {
            debugPrint("ACTIVITIES_SUBJECT: ${subject['lessons']}");

            for (var lesson in subject['lessons']) {
              debugPrint("ACTIVITIES_SUBJECT_LESSON: ${lesson['id']} and $lessonId");
              if (lesson['id'] == lessonId) {
                debugPrint("ACTIVITIES_JSON_INNER: $lesson");

                // ✅ Extract activities list
                final activityList = lesson['activities'] as List;
                debugPrint("ACTIVITIES_LIST: $activityList");
                for (var activity in activityList) {
                  activities.add(ActivityModel.fromJson(activity));
                }
                debugPrint("ACTIVITIES--->: $activities");
              }
            }
          }
        }
      }
    }
    debugPrint("ACTIVITY--->$activities");
    return activities;
  }
}
