import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intello_new/core/navigation/main_navigation_page.dart';
import 'package:intello_new/features/auth/presentation/pages/create_new_password_page.dart';
import 'package:intello_new/features/auth/presentation/pages/login_page.dart';
import 'package:intello_new/features/auth/presentation/pages/signup_page.dart';
import 'package:intello_new/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:intello_new/routes/app_pages.dart';

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
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: CreateNewPasswordPage(), key: state.pageKey),
      ),
      GoRoute(
        path: AppPages.NAVIGATION_SCREEN,
        pageBuilder: (context, state) =>
            _defaultTransitionPage(child: MainNavigationPage(), key: state.pageKey),
      ),
    ],
  );

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
