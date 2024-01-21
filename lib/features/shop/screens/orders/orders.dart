import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/screens/order_detail/order_details.dart';
import 'package:medishield/features/shop/screens/orders/widgets/order_card.dart';
import 'package:medishield/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: ListView.separated(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            itemBuilder: (_, index) => TOrderCard(
                  orderNumber: 'Order #123456',
                  orderDate: '12/12/2020',
                  orderStatus: 'Delivered',
                  orderAmount: '₹ 400',
                  onTap: () => Get.to(() => OrderDetailScreen()),
                ),
            separatorBuilder: (_, __) => SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
            itemCount: 3));
  }
}
