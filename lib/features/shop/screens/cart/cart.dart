import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/screens/cart/widget/cart_item.dart';
import 'package:medishield/features/shop/screens/checkout/checkout.dart';
import 'package:medishield/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.userCart.value.products.isEmpty) {
          return const Center(child: Text('No items in cart'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            return CartItem(
              showQuantity: true,
              product: controller.userCart.value.products,
            );
          }),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.userCart.value.products.isEmpty) return const SizedBox();
        return Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            child: Obx(() => Text('Checkout ₹ ${controller.total}')),
            onPressed: () => Get.off(() => const CheckoutScreen()),
          ),
        );
      }),
    );
  }
}
