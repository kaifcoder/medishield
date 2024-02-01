import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/features/shop/screens/store/widgets/brand_card.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

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
        child: const Column(
          children: [
            BrandCard(),
          ],
        ),
      ),
    );
  }
}
