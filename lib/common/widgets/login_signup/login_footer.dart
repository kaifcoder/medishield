import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihealth/utils/constants/image_strings.dart';
import 'package:medihealth/utils/constants/sizes.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {},
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
      ],
    );
  }
}
