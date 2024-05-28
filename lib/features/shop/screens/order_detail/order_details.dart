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
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    final discount =
        controller.orderData[index].couponApplied?['discount'] ?? 0;

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
              trackingNumber: controller
                      .orderData[index].shippingInfo?['payload']?['awb_code']
                      .toString() ??
                  '',
            ),
            if (controller.orderData[index].orderStatus == 'Shipped')
              TextButton(
                onPressed: () async {
                  // url launcher
                  final Uri url = Uri.parse(
                      'https://shiprocket.co/tracking/${controller.orderData[index].shippingInfo!['payload']?['awb_code']}');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: const Text(
                  'Track Order',
                  style: TextStyle(color: TColors.primary),
                ),
              ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            // show applied coupon
            if (controller.orderData[index].couponApplied != null)
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_offer,
                      color: TColors.primary,
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Text(
                      'Coupon Applied: ${controller.orderData[index].couponApplied!['couponCode'] ?? ''}',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: TColors.primary,
                              ),
                    ),
                  ],
                ),
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
            const TSectionHeading(title: 'Order Items'),
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
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                children: [
                  BillingPaymentDetails(
                    total: (controller.orderData[index].paymentIntent.amount -
                            controller.orderData[index].paymentIntent.shipping +
                            discount)
                        .toInt(),
                    discount: discount,
                    grandTotal:
                        controller.orderData[index].paymentIntent.amount,
                    shippingFee:
                        controller.orderData[index].paymentIntent.shipping,
                  ),
                  BillingAddress(
                    showButton: false,
                    user: controller.orderData[index].orderby,
                    address: controller.orderData[index].shippingAddress,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // contact details
            Text(
              'Contact Us for any queries',
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
