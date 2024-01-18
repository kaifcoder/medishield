import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihealth/common/widgets/appbar/appbar.dart';
import 'package:medihealth/common/widgets/products/cart/t_cart_counter_icon.dart';
import 'package:medihealth/features/shop/screens/cart/cart.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          TTexts.homeAppbarTitle,
          style: Theme.of(context).textTheme.labelMedium!.apply(
                color: TColors.grey,
              ),
        ),
        Text(
          TTexts.homeAppbarSubTitle,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
                color: TColors.white,
              ),
        ),
      ]),
      actions: [
        TCartCounterIcon(
          iconColor: TColors.white,
          onPressed: () => Get.to(
            () => CartScreen(),
          ),
        )
      ],
    );
  }
}
