import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intello_new/features/account/data/repositories/account_repository_impl.dart';
import 'package:intello_new/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:intello_new/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:intello_new/features/lesson_details/data/datasource/lesson_content_local_datasource.dart';
import 'package:intello_new/features/lesson_details/data/repository/lesson_content_repository_impl.dart';
import 'package:intello_new/features/lesson_details_updated/domain/usecases/get_activities.dart';
import 'package:intello_new/features/lesson_details_updated/domain/usecases/get_lessons.dart';
import 'package:intello_new/features/lessons/data/datasource/lesson_local_datasource.dart';
import 'package:intello_new/features/lessons/data/repositories/subject_repository_impl.dart';
import 'package:intello_new/features/lessons/presentation/bloc/lesson_bloc.dart';
import 'package:intello_new/features/subject/presentation/pages/subject_screen.dart';
import 'package:intello_new/routes/app_routes.dart';

import 'features/account/data/datasources/account_local_datasource.dart';
import 'features/account/presentation/bloc/profile_bloc.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'features/lesson_details/domain/usecases/get_lesson_content.dart';
import 'features/lesson_details/presentation/bloc/lesson_content_bloc.dart';
import 'features/lesson_details_updated/data/datasources/learning_local_datasource.dart';
import 'features/lesson_details_updated/data/repositories/learning_repository_impl.dart';
import 'features/lesson_details_updated/presentation/bloc/learning_bloc.dart';
import 'features/lessons/domain/usecases/get_lessons_usecase.dart';
import 'features/settings/bloc/change_password/change_password_bloc.dart';
import 'features/subject/data/datasources/subject_local_datasource.dart';
import 'features/subject/data/repositories/subject_repository_impl.dart';
import 'features/subject/presentation/bloc/subject_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RegistrationBloc(AuthRepositoryImpl(AuthLocalDataSource())),
        ),
        BlocProvider(
          create: (context) =>
              LoginBloc(AuthRepositoryImpl(AuthLocalDataSource())),
        ),
        BlocProvider(
          create: (context) =>
              ChangePasswordBloc(AuthRepositoryImpl(AuthLocalDataSource())),
        ),
        BlocProvider(
          create: (context) =>
              ForgotPasswordBloc(AuthRepositoryImpl(AuthLocalDataSource())),
        ),
        BlocProvider(
          create: (context) =>
              // LearningBloc(GetActivities(LearningRepositoryImpl(LearningLocalDataSourceImpl()))),
              LearningBloc(GetLessons(LearningRepositoryImpl(LearningLocalDataSourceImpl()))),
        ),
        /*BlocProvider(
          create: (context) =>
              ProfileBloc(AccountRepositoryImpl(AccountLocalDataSource())),
        ),*/
        BlocProvider(
          create: (_) =>
              SubjectBloc(SubjectRepositoryImpl(SubjectLocalDataSource())),
          child: SubjectScreen(levelCode: "cp1"),
        ),
        BlocProvider(
          create: (context) =>
              ProfileBloc(AccountRepositoryImpl(AccountLocalDataSource())),
          //       ..add(LoadAccountEvent()),
          // child: const ProfilePage(),
        ),
        /*BlocProvider(
          create: (context) =>
              LessonBloc(context.read())..add(LoadLessonsEvent()),
        ),*/
        BlocProvider(
          create: (context) => LessonBloc(
            GetLessonsUseCase(
              LessonRepositoryImpl(SubjectLocalDataSourceImpl()),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => LessonContentBloc(
            GetLessonContent(
              LessonContentRepositoryImpl(LessonContentLocalDataSourceImpl()),
            ),
          ),
        ),
        //LessonContentBloc
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.rethinkSans(),
            bodyLarge: GoogleFonts.rethinkSans(),
            bodySmall: GoogleFonts.rethinkSans(),
            titleLarge: GoogleFonts.rethinkSans(),
            titleMedium: GoogleFonts.rethinkSans(),
          ),
        ),
        routerDelegate: AppRouters().routers.routerDelegate,
        routeInformationParser: AppRouters().routers.routeInformationParser,
        routeInformationProvider: AppRouters().routers.routeInformationProvider,
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
