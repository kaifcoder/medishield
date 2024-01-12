import 'package:flutter/material.dart';
import 'package:medihealth/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/device/device_utility.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: OnboardingController.instance.skipPage,
        child: const Text(
          'Skip',
        ),
      ),
    );
  }
}
