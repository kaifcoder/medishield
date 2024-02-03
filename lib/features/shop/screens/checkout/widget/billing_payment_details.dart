import 'package:flutter/material.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/utils/constants/sizes.dart';

class BillingPaymentDetails extends StatelessWidget {
  const BillingPaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Column(
      children: [
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '₹ ${controller.total.value}',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shipping Fee',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '₹ 150',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '₹ ${controller.total.value + 150}',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const Divider(),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
      ],
    );
  }
}
