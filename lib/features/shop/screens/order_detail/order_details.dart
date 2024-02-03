import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/shop/controllers/order_controller.dart';
import 'package:medishield/features/shop/screens/checkout/widget/billing_address.dart';
import 'package:medishield/features/shop/screens/checkout/widget/billing_payment_details.dart';
import 'package:medishield/features/shop/screens/order_detail/widgets/order_items.dart';
import 'package:medishield/features/shop/screens/order_detail/widgets/order_tracker.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text('Order Detail',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Order Status'),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            OrderTracker(
              orderStatus: controller.orderData[index].orderStatus ==
                      'Processing'
                  ? 0
                  : controller.orderData[index].orderStatus == 'Shipped'
                      ? 1
                      : controller.orderData[index].orderStatus == 'Delivered'
                          ? 2
                          : 3,
            ),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const TSectionHeading(title: 'Transaction Details'),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              'Transaction-Id: ${controller.orderData[index].paymentIntent.id}',
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const TSectionHeading(title: 'Items'),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            OrderItems(
              oindex: index,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const TSectionHeading(title: 'Billing Details'),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TRoundedContainer(
              showBorder: true,
              backgroundColor: TColors.lightGrey,
              padding: EdgeInsets.all(TSizes.md),
              child: Column(
                children: [
                  BillingPaymentDetails(
                    total: OrderController
                            .instance.orderData[index].paymentIntent.amount -
                        OrderController
                            .instance.orderData[index].paymentIntent.shipping,
                  ),
                  BillingAddress(
                    showButton: false,
                    user: OrderController.instance.orderData[index].orderby,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // contact details
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            TRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(TSizes.md),
              child: Text(
                  "📍 SAI SHREE COMPLEX, 8, BN Road, Kaiserbagh Officer's Colony, Lalbagh, Lucknow,\nUttar Pradesh\n226001\n\n☎️ 0522-4236262",
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }
}
