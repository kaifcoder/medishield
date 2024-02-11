import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/firebase_options.dart';
import 'app.dart';

// Entry point of the app
Future<void> main() async {
  await GetStorage.init();
  // initialize the firebase app
  Get.put(LocationController());
  await LocationController.instance.getCurrentPosition();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
