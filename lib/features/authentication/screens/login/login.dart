import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/styles/spacing_styles.dart';
import 'package:medishield/features/authentication/screens/aboutus/aboutus.dart';
import 'package:medishield/features/authentication/screens/privacy/privacy.dart';
import 'package:medishield/features/authentication/screens/refund/refund.dart';
import 'package:medishield/features/authentication/screens/tnc/tnc.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/login_signup/login_footer.dart';
import '../../../../common/widgets/login_signup/t_divider.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithTopAppBar / 1.5,
          child: Column(
            children: [
              LoginHeader(dark: dark),
              const SizedBox(
                height: TSizes.spaceBtwSections / 2,
              ),
              // const LoginForm(),
              // TDivider(dark: dark, dividerText: TTexts.orSignInWith),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(height: Get.height * 0.5, child: const LoginFooter()),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // terms and conditions
                      TextButton(
                        onPressed: () => Get.to(
                          () => const Tnc(),
                        ),
                        child: Text(
                          'Terms &\nConditions',
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),

                      // privacy policy
                      TextButton(
                        onPressed: () => Get.to(
                          () => const Refund(),
                        ),
                        child: Text(
                          'Refund\nPolicy',
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),

                      // privacy policy
                      TextButton(
                        onPressed: () => Get.to(
                          () => const Privacy(),
                        ),
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),

                      // privacy policy
                      TextButton(
                        onPressed: () => Get.to(
                          () => const AboutUs(),
                        ),
                        child: Text(
                          'About us',
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
