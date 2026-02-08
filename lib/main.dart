import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /*await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);*/

  runApp(const MyApp());
}
