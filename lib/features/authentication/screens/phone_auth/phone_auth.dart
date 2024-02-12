import 'package:flutter/material.dart';
import 'package:awesome_otp_screen/awesome_otp_screen.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen(
      {super.key,
      required this.phoneNumber,
      required this.email,
      required this.name});

  Future<String> validateOtp(String otp) async {
    var isVerified =
        await AuthenticationRepository.instance.verifyOTP(otp, name, email);
    if (isVerified) {
      return "OTP Verified";
    } else {
      Get.back();
      return "Invalid OTP";
    }
  }

  void moveToNextScreen(context) {
    return;
  }

  final String phoneNumber;
  final String email;
  final String name;

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
