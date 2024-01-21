import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/features/shop/screens/cart/widget/cart_item.dart';
import 'package:medishield/features/shop/screens/checkout/checkout.dart';
import 'package:medishield/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: CartItem(
          showQuantity: true,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          child: Text('Checkout '),
          onPressed: () => Get.to(() => CheckoutScreen()),
        ),
      ),
    );
  }
}
