import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.onPressed,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          Iconsax.shopping_bag,
          color: iconColor,
        ),
      ),
      Positioned(
        right: 0,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: TColors.black.withOpacity(0.7),
          ),
          child: Center(
            child: Obx(
              () => Text(
                CartController.instance.userCart.value.products.length
                    .toString(),
                style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: TColors.white,
                    ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
