import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/shop/screens/cart/widget/cart_item.dart';
import 'package:medishield/features/shop/screens/checkout/widget/billing_address.dart';
import 'package:medishield/features/shop/screens/checkout/widget/billing_payment_details.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Checkout', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TSectionHeading(title: 'Order Summary'),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            CartItem(showQuantity: false),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TSectionHeading(title: 'Billing Details'),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TRoundedContainer(
              showBorder: true,
              backgroundColor: TColors.lightGrey,
              padding: EdgeInsets.all(TSizes.md),
              child: Column(
                children: [
                  BillingPaymentDetails(),
                  BillingAddress(
                    showButton: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          child: const Text('Proceed to payment'),
          onPressed: () {},
        ),
      ),
    );
  }
}
