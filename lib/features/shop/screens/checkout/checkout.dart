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
            CartItem(
              showQuantity: false,
              product: controller.userCart.value.products,
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
                    total: controller.total.value,
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
            if (addressController.addresses.isEmpty) {
              CustomSnackbar.errorSnackBar('Please add an address to proceed');
              return;
            }
            await checkout.initiatePayment();
            checkout.openCheckout(
                amount: controller.grandTotal.value,
                name: 'MediShield',
                email: usercontroller.user.value.email!,
                contact: usercontroller.user.value.mobile!);
          },
        ),
      ),
    );
  }
}
