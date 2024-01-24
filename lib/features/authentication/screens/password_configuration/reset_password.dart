import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/authentication/controllers/password_configuration/forget_password_controller.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(children: [
          Image(
            image: const AssetImage(TImages.deliveredEmailIllustration),
            width: THelperFunctions.screenWidth() * 0.6,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          Text(
            TTexts.changeYourPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            TTexts.changeYourPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              child: const Text(TTexts.done),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => controller.resendPasswordEmail(email),
              child: const Text(TTexts.resendEmail),
            ),
          ),
        ]),
      ),
    );
  }
}
