import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopScope extends StatelessWidget {
  const PopScope({
    super.key,
    required this.canPop,
    required this.child,
  });

  final bool canPop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        if (!canPop) {
          return false;
        } else {
          Get.back();
          return true;
        }
      },
    );
  }
}
