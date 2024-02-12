import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:medishield/features/shop/controllers/all_product_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/constants/sizes.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen(
      {super.key, required this.title, required this.product});

  final String title;
  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final allProductController = AllProductController.instance;
    final controller = ProductController.instance;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: product.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('No Product Found'),
                  ),
                ],
              )
            : Obx(() {
                return Column(children: [
                  // filter and sort dropdown

                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                      itemCount: controller.CategoryProducts.length +
                          (controller.isLoadingAnother.value ? 1 : 0),
                      controller: allProductController.scrollController,
                      itemBuilder: (context, index) {
                        if (index < controller.CategoryProducts.length) {
                          return ProductCardHorizontal(
                            product: controller.CategoryProducts[index],
                            isLoadMore: controller.isLoadingAnother.value,
                          );
                        } else {
                          return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: const [
                                SizedBox(
                                  height:
                                      80, // Adjust height according to your loader widget
                                  child: CustomShimmer(
                                      height: 80,
                                      width: double
                                          .infinity), // Or any loader widget
                                ),
                                SizedBox(
                                  height: TSizes.defaultSpace,
                                ),
                                SizedBox(
                                  height:
                                      80, // Adjust height according to your loader widget
                                  child: CustomShimmer(
                                      height: 80,
                                      width: double
                                          .infinity), // Or any loader widget
                                ),
                                SizedBox(
                                  height: TSizes.defaultSpace,
                                ),
                                SizedBox(
                                  height:
                                      80, // Adjust height according to your loader widget
                                  child: CustomShimmer(
                                      height: 80,
                                      width: double
                                          .infinity), // Or any loader widget
                                ),
                              ]);
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: TSizes.spaceBtwItems,
                        );
                      },
                    ),
                  ),
                ]);
              }),
        // sort and filter

        bottomSheet: Obx(() {
          if (controller.isLoadingAnother.value) {
            return const LinearProgressIndicator();
          }
          return const SizedBox();
        }));
  }
}
