import 'package:flutter/material.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/utils/constants/sizes.dart';

class BillingPaymentDetails extends StatelessWidget {
  const BillingPaymentDetails(
      {super.key,
      required this.total,
      required this.discount,
      required this.grandTotal,
      required this.shippingFee});

  final int total;
  final int discount;
  final int grandTotal;
  final int shippingFee;

  @override
  Widget build(BuildContext context) {
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;

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
              ' ${total.toDouble() * rate} $ccy',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        if (discount > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'discount',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '- ${discount.toDouble() * rate} $ccy',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        if (discount > 0)
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
              '${shippingFee.toDouble() * rate} $ccy',
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
              '${grandTotal.toDouble() * rate} $ccy',
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
