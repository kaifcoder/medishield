import 'dart:async';

import 'package:get/get.dart';
import 'package:medishield/common/widgets/success_screen/success_screen.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  @override
  void onInit() {
    sendVerificationMail();
    setTimerAutoRedirect();
    super.onInit();
  }

  Future<void> sendVerificationMail() async {
    try {
      await AuthenticationRepository.instance.sendVerfiyEmail();
    } catch (e) {
      THelperFunctions.showSnackBar(e.toString());
    }
  }

  void setTimerAutoRedirect() async {
    if (await AuthenticationRepository.instance.deviceStorage.read('token') ==
        null) {
      return;
    }
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await AuthenticationRepository.instance
          .isEmailVerified()
          .then((value) => {
                if (value == true)
                  {
                    timer.cancel(),
                    Get.off(
                      () => SuccessScreen(
                        onPressed: () =>
                            AuthenticationRepository.instance.screenRedirect(),
                        title: TTexts.yourAccountCreatedTitle,
                        subtitle: TTexts.yourAccountCreatedSubTitle,
                        image: TImages.staticSuccessIllustration,
                      ),
                    ),
                  }
              });
    });
  }

  checkForEmailVerificationManually() {
    AuthenticationRepository.instance.isEmailVerified().then((value) => {
          if (value == true)
            {
              Get.off(
                () => SuccessScreen(
                  onPressed: () =>
                      AuthenticationRepository.instance.screenRedirect(),
                  title: TTexts.yourAccountCreatedTitle,
                  subtitle: TTexts.yourAccountCreatedSubTitle,
                  image: TImages.staticSuccessIllustration,
                ),
              ),
            }
        });
  }
}
