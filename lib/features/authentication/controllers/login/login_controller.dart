import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/helpers/network_manager.dart';
import 'package:medishield/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: 'loginFormKey');

  Future<void> login() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'we are processing your information', TImages.loader);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return THelperFunctions.showSnackBar('No internet connection');
      }
      // //form validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .login(email.text.trim(), password.text.trim());

      FullScreenLoader.stopLoading();

      await AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      THelperFunctions.showSnackBar('Oh Snap! $e');
    }
  }
}
