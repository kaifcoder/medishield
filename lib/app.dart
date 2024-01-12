import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihealth/features/authentication/screens/onboarding/onboarding.dart';
import 'package:medihealth/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: MediShieldTheme.lightTheme,
      darkTheme: MediShieldTheme.darkTheme,
      home: const Onboarding(),
    );
  }
}
