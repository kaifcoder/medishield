import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Product'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(TSizes.defaultSpace / 2),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ProductCardHorizontal();
          }),
    );
  }
}
