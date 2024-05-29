import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medishield/bindings/general_bindings.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/shop/screens/product_details/product_shared.dart';
import 'package:medishield/utils/theme/theme.dart';
import 'dart:async';
import 'package:uni_links2/uni_links.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _initDeepLinkListener() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleUri(uri);
      }
    }, onError: (err) {
      // Handle error
      debugPrint('Error: $err');
    });
  }

  Future<void> _handleInitialUri() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        _handleUri(initialUri);
      }
    } catch (err) {
      // Handle error
    }
  }


  void _handleUri(Uri uri) {
    String path = uri.path;
    if (path.startsWith('/product/')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(path);
      });
    }
  }



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
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/product/:id',
          page: () => const ProductShared(),
        ),
      ],
    );
  }
}
