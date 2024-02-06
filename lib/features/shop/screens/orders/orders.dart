import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/order_controller.dart';
import 'package:medishield/features/shop/screens/order_detail/order_details.dart';
import 'package:medishield/features/shop/screens/orders/widgets/order_card.dart';
import 'package:medishield/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    if (controller.orderData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: const Center(
          child: Text('No Orders Yet'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title:
            Text('My Orders', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        itemBuilder: (_, index) => TOrderCard(
          orderNumber: 'Order #${controller.orderData[index].id}',
          orderDate: controller.orderData[index].createdAt,
          name: controller.orderData[index].products.first.product.name,
          orderStatus: controller.orderData[index].orderStatus,
          orderAmount: '₹ ${controller.orderData[index].paymentIntent.amount}',
          onTap: () => Get.to(
            () => OrderDetailScreen(
              index: index,
            ),
          ),
          count: controller.orderData[index].products.length,
        ),
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        itemCount: controller.orderData.length,
      ),
    );
  }
}
