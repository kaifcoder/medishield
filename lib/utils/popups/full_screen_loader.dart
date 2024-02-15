import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/animation_loader.dart';
import 'package:medishield/utils/popups/pop_scope.dart' as medishield;

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => medishield.PopScope(
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
