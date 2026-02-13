import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intello_new/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:intello_new/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:intello_new/routes/app_routes.dart';

import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'features/settings/bloc/change_password/change_password_bloc.dart';

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
