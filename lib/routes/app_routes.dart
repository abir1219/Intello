import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/features/account/presentation/pages/profile_page.dart';
import 'package:intello_new/features/auth/presentation/pages/create_new_password_page.dart';
import 'package:intello_new/features/auth/presentation/pages/login_page.dart';
import 'package:intello_new/features/auth/presentation/pages/phone_validation.dart';
import 'package:intello_new/features/auth/presentation/pages/signup_page.dart';
import 'package:intello_new/features/exercise/presentation/pages/example_details.dart';
import 'package:intello_new/features/lesson_details/domain/entity/exercise.dart';
import 'package:intello_new/features/lesson_details_updated/data/models/activity_model.dart' show ActivityModel;
import 'package:intello_new/features/lesson_details_updated/data/models/game_model.dart';
import 'package:intello_new/features/lesson_details_updated/presentation/pages/activity_flow_screen.dart';
import 'package:intello_new/features/lesson_details_updated/presentation/pages/lecture_page.dart';
// import 'package:intello_new/features/lesson_details_updated/presentation/pages/lesson_details.dart';
import 'package:intello_new/features/lessons/presentation/pages/lesson_screen.dart';
import 'package:intello_new/features/level/presentation/pages/level_screen.dart';
import 'package:intello_new/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:intello_new/features/settings/page/change_password_page.dart';
import 'package:intello_new/features/subject/presentation/pages/subject_screen.dart';
import 'package:intello_new/routes/app_pages.dart';

import '../features/lesson_details_updated/presentation/pages/lesson_page_updated.dart';
import '../features/splash/presentation/pages/splash_screen.dart';

class AppRouters {
  static final GoRouter _router = GoRouter(
    initialLocation: AppPages.SPLASH_SCREEN,
    routes: [
      GoRoute(
        path: AppPages.SPLASH_SCREEN,
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: SplashScreen(), key: state.pageKey),
      ),
      GoRoute(
        path: AppPages.ONBOARDING_SCREEN,
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: OnboardingPage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppPages.SIGNUP_SCREEN,
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: SignUpPage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppPages.LOGIN_SCREEN,
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: LoginPage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppPages.CREATE_NEW_PASSWORD_SCREEN,
        pageBuilder: (context, state) => _defaultTransitionPage(
          child: CreateNewPasswordPage(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: AppPages.CHANGE_PASSWORD_SCREEN,
        pageBuilder: (context, state) => _defaultTransitionPage(
          child: ChangePasswordPage(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: AppPages.PROFILE_SCREEN,
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: ProfilePage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppPages.SUBJECT_SCREEN,
        pageBuilder: (context, state) {
          return _defaultTransitionPage(
            child: SubjectScreen(levelCode: state.extra as String),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: AppPages.PHONE_VALIDATE_SCREEN,
        pageBuilder: (context, state) => _defaultTransitionPage(
          child: PhoneValidation(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: AppPages.LEVEL_SCREEN,
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: LevelScreen(), key: state.pageKey),
      ),
      GoRoute(
        path: AppPages.LESSON_DETAILS_SCREEN,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          print("LirePlue-->${data['lirePlus']}");

          return _defaultTransitionPage(
            // child: LessonDetails(
            child: LessonDetailsUpdate(
              subject: data['subjectId'] as String,
              level: data['levelCode'] as String,
              levelName: data['levelName'],
              lessonId: data['lessonId'],
              content: data['content'],
                isMore: data['isMore'],
                lirePlus: data['lirePlus']
            ),
            key: state.pageKey,
          );
        },
      ),

      GoRoute(
        path: AppPages.LESSON_SCREEN,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return _defaultTransitionPage(
            child: LessonScreen(
              subject: data['subjectId'] as String,
              level: data['levelCode'] as String,
            ),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: AppPages.EXAMPLE_DETAILS_SCREEN,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return _defaultTransitionPage(
            child: ExampleDetails(
              subject: data['subject'] as String,
              level: data['level'] as String,
              levelName: data['levelName'] as String,
              lessonId: data['lessonId'] as String,
              exercise: data['exercise'] as Exercise,
            ),
            key: state.pageKey,
          );
        },
      ),
      /*GoRoute(
        path: AppPages.ACTIVITY_FLOW_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?? {};

          return _defaultTransitionPage(
            key: state.pageKey,
            child: ActivityFlowScreen(
              activities: extra["activities"] as List<ActivityModel>,
              games: extra["games"] as List<GameModel>,
            ),
          );
        },
      ),*/
      GoRoute(
        path: AppPages.ACTIVITY_FLOW_SCREEN,
        pageBuilder: (context, state) {

          final extra = state.extra as Map<String, dynamic>? ?? {};

          return _defaultTransitionPage(

            key: state.pageKey,

            child: ActivityFlowScreen(

              activities:
              (extra["activities"] as List<ActivityModel>?) ?? [],

              games:
              (extra["games"] as List<GameModel>?) ?? [],
            ),
          );
        },
      ),
      GoRoute(
        path: AppPages.LECTURE_SCREEN,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          debugPrint("Data-->${data}");

          return _defaultTransitionPage(
            key: state.pageKey,
            child: LecturePage(pdfPath: data['pdf'] as String,
              subject: data['subject'] as String,
              level: data['level'] as String,
            ),
          );
        },
      ),
    ],
  );
//LECTURE_SCREEN
  GoRouter get routers => _router;

  static CustomTransitionPage _defaultTransitionPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
