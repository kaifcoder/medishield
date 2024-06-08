import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(
              dark ? TImages.appLogo : TImages.appLogo,
            ),
            height: 120,
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
    ]);
  }
}
