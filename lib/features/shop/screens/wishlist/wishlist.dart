import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medihealth/common/widgets/appbar/appbar.dart';
import 'package:medihealth/common/widgets/icons/t_circular_icon.dart';
import 'package:medihealth/common/widgets/layouts/grid_layout.dart';
import 'package:medihealth/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            dark: dark,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              GridLayout(
                itemCount: 5,
                itemBuilder: (context, index) => const ProductCardVertical(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
