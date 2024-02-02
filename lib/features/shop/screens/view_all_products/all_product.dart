import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen(
      {super.key, required this.title, required this.product});

  final String title;
  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: product.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('No Product Found'),
                ),
              ],
            )
          : ListView.separated(
              padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
              itemCount: product.length,
              itemBuilder: (context, index) {
                return ProductCardHorizontal(
                  product: product[index],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: TSizes.spaceBtwItems,
                );
              }),
    );
  }
}
