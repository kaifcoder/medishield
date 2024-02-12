import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/authentication/controllers/google_sign_in_controller/google_controller.dart';
import 'package:medishield/features/authentication/controllers/login/phone_controller.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GoogleController());
    final phoneController = Get.put(PhoneController());
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
        const SizedBox(
          width: TSizes.md,
        ),
        OutlinedButton(
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
              Text('OTP'.capitalize!),
            ],
          ),
        ),
      ],
    );
  }
}
