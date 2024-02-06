import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medishield/bindings/general_bindings.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'MediSheild',
      themeMode: ThemeMode.light,
      theme: MediShieldTheme.lightTheme,
      darkTheme: MediShieldTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      home: const LoginScreen(),
    );
  }
}
