import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medishield/bindings/general_bindings.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/shop/screens/product_details/product_details.dart';
import 'package:medishield/utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'MediShield',
      themeMode: ThemeMode.light,
      theme: MediShieldTheme.lightTheme,
      darkTheme: MediShieldTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      home: const LoginScreen(),
      routes: {
        '/product': (context) => const LoginScreen(),
      },
    );
  }
}
