import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/checkout_controller.dart';
import 'package:medishield/features/personalization/controllers/user_controller.dart';
import 'package:medishield/features/shop/screens/cart/widget/cart_item.dart';
import 'package:medishield/features/shop/screens/checkout/widget/billing_address.dart';
import 'package:medishield/features/shop/screens/checkout/widget/billing_payment_details.dart';
import 'package:medishield/features/shop/screens/checkout/widget/coupon_dialog.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    final usercontroller = UserController.instance;
    final addressController = AddressController.instance;
    final checkout = Get.put(CheckoutController());
    return Scaffold(
      appBar: TAppBar(
        title:
            Text('Checkout', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const TSectionHeading(title: 'Order Summary'),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Obx(
              () => CartItem(
                showQuantity: false,
                product: controller.userCart.value.products,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // add button to invoke bottom sheet to apply coupons here

            Obx(() {
              if (controller.couponApplied.value) {
                return TRoundedContainer(
                  showBorder: true,
                  backgroundColor: TColors.lightGrey,
                  padding: const EdgeInsets.all(TSizes.md),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.local_offer,
                            color: TColors.primary,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Coupon Applied: ${controller.coupon.value}',
                            style: const TextStyle(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                controller.couponApplied.value = false;
                                controller.coupon.value = '';
                                controller.couponId.value = '';
                                controller.coupondiscount.value = 0;
                                controller.couponMsc.value = 0;
                                controller.handleCoupon();
                              },
                              child: const Text(
                                'Remove',
                                style: TextStyle(color: TColors.primary),
                              ))
                        ],
                      ),
                    ],
                  ),
                );
              }
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: TColors.primary,
                    backgroundColor: TColors.lightGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // show bottom sheet
                    Get.bottomSheet(
                      isScrollControlled: true,
                      const CouponDialog(),
                      backgroundColor: TColors.white,
                      enableDrag: true,
                    );
                  },
                  child: const Text('Apply Coupon'),
                ),
              );
            }),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // promotional container for free delivery on purchase of 2000 or more
            const TRoundedContainer(
              showBorder: true,
              backgroundColor: TColors.lightGrey,
              padding: EdgeInsets.all(TSizes.md),
              child: Column(
                children: [
                  Text(
                    'Get free delivery on purchase of 2000 or more',
                    style: TextStyle(
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
                  Obx(
                    () => BillingPaymentDetails(
                      total: controller.total.value.toInt(),
                      discount: controller.coupondiscount.value.toInt(),
                      grandTotal: controller.grandTotal.value.toInt(),
                      shippingFee: controller.shippingCharges,
                    ),
                  ),
                  Obx(
                    () => BillingAddress(
                      showButton: true,
                      user: usercontroller.user.value,
                      address: addressController.selectedAddress.value,
                    ),
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
          onPressed: () async {
            if (addressController.selectedAddress.value.address == null) {
              CustomSnackbar.errorSnackBar('Please add an address to proceed');
              return;
            }
            await checkout.initiatePayment();
            checkout.openCheckout(
                amount: controller.grandTotal.value.toInt(),
                name: 'MediShield',
                email: usercontroller.user.value.email!,
                contact: addressController.selectedAddress.value.mobile!);
            // checkout.test();
          },
        ),
      ),
    );
  }
}
