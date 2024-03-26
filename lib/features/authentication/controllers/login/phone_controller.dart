import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';

class PhoneController extends GetxController {
  static PhoneController get instance => Get.find();
  var code = '91';
  final phone = TextEditingController();
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
          .signInWithPhone('+$code${phone.text.trim()}');
    } catch (e) {
      debugPrint('Error in signInWithPhone $e');
    }
  }
}
