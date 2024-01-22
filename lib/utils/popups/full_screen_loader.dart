import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:medishield/common/widgets/animation_loader.dart';

import 'pop_scope.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            AnimationLoader(
              animation: animation,
              text: text,
            )
          ]),
        ),
      ),
    );
  }

  //stop loading
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
