import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intello_new/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}