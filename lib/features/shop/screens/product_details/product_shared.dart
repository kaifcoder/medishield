import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/home_controller.dart';
import 'package:medishield/features/shop/screens/product_details/product_share_controller.dart';

class ProductShared extends StatelessWidget {
  const ProductShared({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(ProductShareController());

    return const Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading product details...'),
        ],
      )),
    );
  }
}
