import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/authentication/controllers/google_sign_in_controller/google_controller.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoogleController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () => controller.googleSignIn(),
          child: Row(
            children: [
              const Image(
                image: AssetImage(TImages.google),
                height: TSizes.iconMd,
                width: TSizes.iconMd,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text('Google'.capitalize!),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () => controller.phoneSignIn(),
          child: Row(
            children: [
              const Icon(
                Icons.phone,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text('OTP'.capitalize!),
            ],
          ),
        ),
      ],
    );
  }
}
