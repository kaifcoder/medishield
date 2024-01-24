import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/features/shop/screens/view_all_products/all_product.dart';

class CategoiesScreen extends StatelessWidget {
  const CategoiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TAppBar(
          title: Text('Categoies'),
          showBackArrow: true,
        ),
        body: ListView.builder(
          itemCount: 21,
          itemBuilder: (context, index) => ExpansionTile(
            childrenPadding: const EdgeInsets.only(left: 20),
            title: Text(
              'Category $index',
            ),
            children: [
              ListTile(
                title: const Text('View All'),
                onTap: () => Get.to(() => const AllProductScreen()),
              ),
              ListTile(
                title: const Text('Sub Category 1'),
                onTap: () => Get.to(() => const AllProductScreen()),
              ),
              ExpansionTile(
                  childrenPadding: const EdgeInsets.only(left: 20),
                  title: const Text('sub category 4'),
                  children: [
                    ListTile(
                      title: const Text('Sub Category 1'),
                      onTap: () => Get.to(() => const AllProductScreen()),
                    ),
                  ]),
            ],
          ),
        ));
  }
}
