import 'package:flutter/material.dart';
import 'package:medihealth/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/device/device_utility.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = OnboardingController.instance;
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController, // PageController
        count: 3,
        onDotClicked: controller.dotNavigationClicked,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? TColors.light : TColors.dark,
          dotHeight: 6,
          dotWidth: 8,
        ),
      ),
    );
  }
}
