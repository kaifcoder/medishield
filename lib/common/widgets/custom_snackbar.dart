import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static successSnackBar(String message) {
    return Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(8),
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
      ),
    );
  }

  static warningSnackBar(String message) {
    return Get.snackbar(
      'Warning',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      margin: const EdgeInsets.all(8),
      colorText: Colors.white,
      icon: const Icon(
        Icons.warning_amber_outlined,
        color: Colors.white,
      ),
    );
  }

  static errorSnackBar(String message) {
    return Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(8),
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
    );
  }
}
