import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medihealth/features/shop/screens/store/widgets/brand_card.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TSizes.defaultSpace / 2),
      child: TRoundedContainer(
        showBorder: true,
        borderColor: THelperFunctions.isDarkMode(context)
            ? TColors.grey
            : TColors.darkGrey,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: const Column(
          children: [
            BrandCard(),
          ],
        ),
      ),
    );
  }
}
