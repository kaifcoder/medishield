import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medishield/common/widgets/login_signup/t_divider.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/controllers/google_sign_in_controller/google_controller.dart';
import 'package:medishield/features/authentication/controllers/login/phone_controller.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoogleController());
    final phoneController = Get.put(PhoneController());
    final auth = AuthenticationRepository.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.sm,
          ),
          child: OutlinedButton(
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
                Text('Sign Up with Google'.capitalize!),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
          child: OutlinedButton(
            onPressed: () => Get.bottomSheet(
              SingleChildScrollView(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Form(
                  key: phoneController.phoneAuthKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TSectionHeading(
                        title: 'Enter your Phone number',
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      IntlPhoneField(
                        initialCountryCode: 'IN',
                        decoration:
                            const InputDecoration(hintText: 'Phone number'),
                        keyboardType: TextInputType.phone,
                        controller: phoneController.phone,
                        onCountryChanged: (value) =>
                            phoneController.codeChanged(value.fullCountryCode),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          phoneController.signInWithPhone();
                        },
                        child: const SizedBox(
                            width: double.infinity,
                            child: Center(child: Text("Get OTP"))),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.white,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text('Sign Up with Mobile Number'.capitalize!),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
          child: OutlinedButton(
            onPressed: () async {
              try {
                await auth.signInWithApple();
              } catch (e) {
                THelperFunctions.showSnackBar(
                    "Could not sign in with Apple. If on android Please try again on apple device.");
              }
            },
            child: Row(
              children: [
                const Image(
                  image: AssetImage(TImages.apple),
                  height: TSizes.iconMd,
                  width: TSizes.iconMd,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text('Sign Up with Apple'.capitalize!),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.sm,
        ),

        TDivider(dark: dark, dividerText: "OR"),
        const SizedBox(
          height: TSizes.sm,
        ),

        /// skip button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
          child: OutlinedButton(
            onPressed: () {
              auth.skipLogin();
            },
            child: Row(
              children: [
                const Icon(
                  Iconsax.forward,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text('Skip Login'.capitalize!),
              ],
            ),
          ),
        )
      ],
    );
  }
}
