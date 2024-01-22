import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';

// Entry point of the app
Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MyApp());
}
