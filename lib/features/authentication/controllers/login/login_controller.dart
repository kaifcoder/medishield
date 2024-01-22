import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/helpers/network_manager.dart';
import 'package:medishield/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  Future<void> login() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'we are processing your information', TImages.loader);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return THelperFunctions.showSnackBar('No internet connection');
      }
      // //form validation
      if (!loginFormKey.currentState!.validate()) return;
    } catch (e) {
      THelperFunctions.showSnackBar('Oh Snap! ' + e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }
}
