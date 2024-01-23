import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/features/authentication/screens/signup/verify_email.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/helpers/network_manager.dart';
import 'package:medishield/utils/popups/full_screen_loader.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final hidePassword = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    try {
      // //start loading
      FullScreenLoader.openLoadingDialog(
          'we are processing your information', TImages.loader);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return THelperFunctions.showSnackBar('No internet connection');
      }

      // //form validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // set data in model
      final data = UserModel(
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        password: password.text.trim(),
        mobile: phoneNumber.text.trim(),
      );

      // call signup api

      await AuthenticationRepository.instance.signup(data);
      FullScreenLoader.stopLoading();
      THelperFunctions.showSnackBar('Congrats! You are registered');
      // navigate to verify email

      Get.off(() => VerifyEmail(email: email.text.trim()));
    } catch (e) {
      FullScreenLoader.stopLoading();
      var err = e.toString().replaceAll('Exception: ', '');
      THelperFunctions.showSnackBar('Oh Snap! $err');
    }
  }
}
