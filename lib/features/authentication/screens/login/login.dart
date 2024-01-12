import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medihealth/common/styles/spacing_styles.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/image_strings.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/constants/text_strings.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithTopAppBar,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(
                        dark ? TImages.lightAppLogo : TImages.darkAppLogo),
                    height: 150,
                  ),
                  Text(TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(
                    height: TSizes.sm,
                  ),
                  Text(TTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct5),
                        labelText: TTexts.email,
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.lock),
                        labelText: TTexts.password,
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            const Text(TTexts.rememberMe),
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(TTexts.forgetPassword))
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(TTexts.signIn),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(TTexts.createAccount),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections / 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark ? TColors.darkGrey : TColors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text(TTexts.orSignInWith.capitalize!,
                      style: Theme.of(context).textTheme.labelMedium),
                  Flexible(
                    child: Divider(
                      color: dark ? TColors.darkGrey : TColors.grey,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 60,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image(
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
