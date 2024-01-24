import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/helpers/network_manager.dart';
import 'package:medishield/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> emailFormKey =
      GlobalKey<FormState>(debugLabel: 'forgetPasswordFormKey');

  forgetPassword() async {
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
      if (!emailFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.forgetPassword(email.text.trim());
      FullScreenLoader.stopLoading();
      email.clear();
      Get.off(() => ResetPasswordScreen(
            email: email.text.trim(),
          ));

      THelperFunctions.showSnackBar(
          'We have sent you an email to reset your password');
    } catch (e) {
      FullScreenLoader.stopLoading();
      THelperFunctions.showSnackBar('Oh Snap! $e');
    }
  }

  resendPasswordEmail(String email) async {
    try {
      await AuthenticationRepository.instance.forgetPassword(email.trim());
      THelperFunctions.showSnackBar(
          'We have sent you an email to reset your password');
    } catch (e) {
      THelperFunctions.showSnackBar('Oh Snap! $e');
    }
  }
}
