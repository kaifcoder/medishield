import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/phone_auth/phone_auth.dart';

class PhoneController extends GetxController {
  static PhoneController get instance => Get.find();
  var code = '91';
  final phone = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  GlobalKey<FormState> phoneAuthKey =
      GlobalKey<FormState>(debugLabel: 'phoneAuth');

  codeChanged(String value) {
    code = value;
    update();
  }

  signInWithPhone() async {
    try {
      if (!phoneAuthKey.currentState!.validate()) {
        return;
      }

      await AuthenticationRepository.instance
          .signInWithPhone('+$code${phone.text}');
      Get.to(
        () => OTPScreen(
          phoneNumber: phone.text.trim(),
          email: email.text.trim(),
          name: name.text.trim(),
        ),
      );
    } catch (e) {
      debugPrint('Error in signInWithPhone $e');
    }
  }
}
