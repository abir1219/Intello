import 'package:flutter/material.dart';
import 'app.dart';
import 'core/storage/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  /*await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);*/

  runApp(const MyApp());
}
