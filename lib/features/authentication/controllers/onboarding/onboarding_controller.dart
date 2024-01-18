import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihealth/features/authentication/screens/login/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPage = 0.obs;

  void updatePageIndicator(index) => currentPage.value = index;

  void dotNavigationClicked(index) {
    currentPage.value = index;
    pageController.animateToPage(
      currentPage.value,
      duration:
          const Duration(milliseconds: 300), // Adjust the duration as needed
      curve: Curves.easeInOut, // Adjust the animation curve if desired
    );
  }

  void nextPage() {
    if (currentPage.value == 2) {
      Get.offAll(() => const LoginScreen());
    } else {
      int page = currentPage.value + 1;
      pageController.animateToPage(
        page,
        duration:
            const Duration(milliseconds: 300), // Adjust the duration as needed
        curve: Curves.easeInOut, // Adjust the animation curve if desired
      );
    }
  }

  void skipPage() {
    Get.offAll(() => const LoginScreen());
  }
}
