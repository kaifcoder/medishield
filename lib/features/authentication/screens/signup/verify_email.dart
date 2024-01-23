import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/success_screen/success_screen.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: const AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                email,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                TTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      controller.checkForEmailVerificationManually(),
                  child: const Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendVerificationMail(),
                      child: const Text(TTexts.resendEmail)))
            ],
          ),
        ),
      ),
    );
  }
}
