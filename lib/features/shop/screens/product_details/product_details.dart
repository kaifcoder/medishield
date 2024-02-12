import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/controllers/product_variants_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/features/shop/screens/checkout/checkout.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/bottom_add_to_cartbar.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/product_variants.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/qa_widget.dart';
import 'package:medishield/utils/constants/sizes.dart';

import 'widgets/product_image_slider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, this.id = 0, required this.product});

  final int id;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final variantController = Get.put(ProductVariantsController());
    final cartController = CartController.instance;
    if (id != 0) {
      // fetch product by id
      controller.getProductById(id);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product images carousel
            ProductImageSlider(
              product: product,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Column(
                children: [
                  // const ReviewText(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ProductMetaData(
                    title: product.name,
                    shortDescription: product.shortDescription,
                    manufacturer: product.name.split(' ')[0],
                    price: product.price.minimalPrice.toDouble(),
                    originalPrice: product.price.regularPrice.toDouble(),
                    discount: product.price.minimalPrice.toDouble(),
                    child: product.childProducts.length > 1,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// product variants
                  if (product.childProducts.length > 1)
                    const TSectionHeading(title: 'Product Variants'),
                  if (product.childProducts.length > 1)
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                  if (product.childProducts.length > 1)
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: product.childProducts.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => ChildProductDisplay(
                            ontap: () => variantController.selectVariant(
                                product.childProducts[index].id, index),
                            selected:
                                variantController.selectedVariantIndex.value ==
                                    index,
                            title: product.childProducts[index].name,
                            price: product
                                .childProducts[index].price.minimalPrice
                                .toDouble(),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                    ),

                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (AuthenticationRepository.instance.deviceStorage
                                .read('token') ==
                            null) {
                          Get.offAll(() => const LoginScreen());
                          return;
                        }
                        // add to cart
                        cartController.addToCart(
                          product: product.prodId,
                          count: 1,
                          price: product.childProducts.length > 1
                              ? product
                                          .childProducts[variantController
                                              .selectedVariantIndex.value]
                                          .price
                                          .minimalPrice ==
                                      0
                                  ? product
                                      .childProducts[variantController
                                          .selectedVariantIndex.value]
                                      .specialPrice!
                                  : product
                                      .childProducts[variantController
                                          .selectedVariantIndex.value]
                                      .price
                                      .minimalPrice
                              : product.price.minimalPrice,
                          v: product.childProducts.length > 1
                              ? product
                                  .childProducts[variantController
                                      .selectedVariantIndex.value]
                                  .sku
                              : product.sku,
                        );
                        // navigate to cart
                        await Get.to(() => const CheckoutScreen());
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// product description
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      initiallyExpanded: false,
                      title: const Text('Description'),
                      children: [
                        Html(
                            data: '''${product.productSpecs['description']}'''),
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Text('Key Specification'),
                      children: [
                        Html(
                            data:
                                '''${product.productSpecs['key_specifications']}'''),
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Text('Packaging'),
                      children: [
                        Html(data: '''${product.productSpecs['packaging']}'''),
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Text('Direction To Use'),
                      children: [
                        Html(
                            data:
                                '''${product.productSpecs['direction_to_use']}''')
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: const Text('Features'),
                      children: [
                        Html(data: '''${product.productSpecs['features']}'''),
                      ]),
                  ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      tilePadding: EdgeInsets.zero,
                      initiallyExpanded: true,
                      title: const Text('FAQs'),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.qaData.isEmpty)
                              const Center(
                                child: Text('No questions found'),
                              ),
                            if (product.qaData.isNotEmpty)
                              ListView.separated(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return QnA(
                                      index: index + 1,
                                      question: product.qaData[index].question,
                                      answer: product.qaData[index].answer,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: TSizes.sm,
                                        child: Divider(
                                          color: Colors.grey,
                                          height: 1.5,
                                        ),
                                      ),
                                  itemCount: product.qaData.length),
                            const SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {},
                                child: const Text('Ask a question'))
                          ],
                        )
                      ]),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // const TSectionHeading(
                  //   title: 'Reviews (233)',
                  // ),
                  // const SizedBox(
                  //   height: TSizes.spaceBtwItems,
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const OverallProductRating(),
                  //     const TRatingBarIndicator(rating: 4.5),
                  //     const Text('1,100'),
                  //     const SizedBox(
                  //       height: TSizes.spaceBtwItems,
                  //     ),
                  //     ListView.separated(
                  //       padding: EdgeInsets.zero,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       shrinkWrap: true,
                  //       itemCount: 2,
                  //       itemBuilder: (context, index) => const UserReview(),
                  //       separatorBuilder: (context, index) => const Divider(),
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: TSizes.spaceBtwSections,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAddToCartBar(
        product: product,
      ),
    );
  }
}
