import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/layouts/grid_layout.dart';
import 'package:medishield/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:medishield/features/shop/controllers/wishlist_controller.dart';
import 'package:medishield/utils/constants/sizes.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WishlistController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'WishList',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: controller.wishlist.isEmpty
          ? const Center(
              child: Text('No items in wishlist'),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    Obx(() {
                      return GridLayout(
                        itemCount: controller.wishlist.length,
                        itemBuilder: (context, index) => ProductCardVertical(
                          product: controller.wishlist[index],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
    );
  }
}
