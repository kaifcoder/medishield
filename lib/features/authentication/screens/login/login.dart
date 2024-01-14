import 'package:flutter/material.dart';
import 'package:medihealth/common/styles/spacing_styles.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/constants/text_strings.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';

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
          padding: TSpacingStyle.paddingWithTopAppBar,
          child: Column(
            children: [
              LoginHeader(dark: dark),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const LoginForm(),
              TDivider(dark: dark, dividerText: TTexts.orSignInWith),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const LoginFooter()
            ],
          ),
        ),
      ),
    );
  }
}
