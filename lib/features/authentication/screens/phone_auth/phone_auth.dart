import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_otp_screen/awesome_otp_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:medishield/utils/exceptions/firebase_exceptions.dart';
import 'package:medishield/utils/exceptions/platform_exceptions.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key, required this.phoneNumber});

  Future<String> validateOtp(String otp) async {
    try {
      var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
      if (isVerified) {
        return "OTP Verified";
      } else {
        Get.back();
        return "Invalid OTP";
      }
    } on FirebaseAuthException catch (e) {
      return TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      return TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      debugPrint(TPlatformException(e.code).message);
      return TPlatformException(e.code).message;
    } catch (e) {
      Get.back();
      return 'An error occurred. Please try again later.';
    }
  }

  void moveToNextScreen(context) {
    return;
  }

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return AwesomeOtpScreen.withGradientBackground(
      topColor: const Color.fromARGB(255, 63, 160, 235),
      bottomColor: const Color.fromARGB(255, 0, 23, 200),
      otpLength: 6,
      validateOtp: validateOtp,
      routeCallback: moveToNextScreen,
      themeColor: Colors.white,
      titleColor: Colors.white,
      title: "Phone Number Verification",
      subTitle: "Enter the code sent to \n $phoneNumber",
    );
  }
}
