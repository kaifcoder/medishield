import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/controllers/product_variants_controller.dart';
import 'package:medishield/features/shop/controllers/review_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/features/shop/screens/checkout/checkout.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/bottom_add_to_cartbar.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/product_variants.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/qa_widget.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/review_text.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'widgets/product_image_slider.dart';
import 'widgets/user_review.dart';
import 'widgets/overall_product_rating.dart';
import 'widgets/t_rating_bar_indicator.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, this.id = "", required this.product});

  final String id;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final variantController = Get.put(ProductVariantsController());
    final cartController = CartController.instance;
    final ratingController = Get.put(RatingController());
    if (id != '') {
      // fetch product by id
      controller.getProductById(id);
    }
    final totalRatings =
        product.ratings!.isNotEmpty ? product.ratings!.length : 1;
    final countStars = ProductModel.countRatings(product.ratings!);
    final averageRating = ProductModel.getaverageRating(
        totalRatings,
        countStars[5]!,
        countStars[4]!,
        countStars[3]!,
        countStars[2]!,
        countStars[1]!);
    debugPrint('averageRating: $averageRating');
    debugPrint('totalRatings: $totalRatings');
    debugPrint('prodId: ${product.prodId}');
    if (product.prodId.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Product not found')),
      );
    } else {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewText(
                      reviewCount: product.ratings!.length.toString(),
                      averageRating: averageRating.toStringAsFixed(1),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    ProductMetaData(
                      title: product.name,
                      isInStock: product.isInStock,
                      shortDescription: product.shortDescription,
                      manufacturer: product.childProducts.length > 1
                          ? ProductModel.getManufacture(
                              product.childProducts[0].manufacturer)
                          : ProductModel.getManufacture(product.manufacturer),
                      price: product.price.minimalPrice.toDouble(),
                      originalPrice: product.price.regularPrice.toDouble(),
                      discount: product.price.minimalPrice.toDouble(),
                      child: product.childProducts.length > 1,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    if (product.msc != 0 && product.msc != null)
                      Row(
                        children: [
                          Icon(
                            Iconsax.coin,
                            color: Colors.amber.shade800,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems / 3,
                          ),
                          Text(
                            'earn ${product.msc} MSC',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Colors.amber.shade800,
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
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
                                  product.childProducts[index].sku, index),
                              selected: variantController
                                      .selectedVariantIndex.value ==
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
                    if (product.isInStock)
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
                              data:
                                  '''${product.productSpecs['description']}'''),
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
                          Html(
                              data: '''${product.productSpecs['packaging']}'''),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return QnA(
                                        index: index + 1,
                                        question:
                                            product.qaData[index].question,
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
                            ],
                          )
                        ]),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    const TSectionHeading(
                      title: 'Reviews & Ratings',
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OverallProductRating(
                          averageRating: averageRating.toStringAsFixed(1),
                          fiveStarRating: countStars[5]! / totalRatings,
                          fourStarRating: countStars[4]! / totalRatings,
                          threeStarRating: countStars[3]! / totalRatings,
                          twoStarRating: countStars[2]! / totalRatings,
                          oneStarRating: countStars[1]! / totalRatings,
                        ),
                        TRatingBarIndicator(rating: averageRating),
                        Text('${product.ratings!.length} ratings'),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.bottomSheet(
                                  backgroundColor: Colors.white,
                                  SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const TSectionHeading(
                                            title: 'Write a review',
                                          ),
                                          const SizedBox(
                                            height: TSizes.spaceBtwItems,
                                          ),
                                          RatingBar(
                                              ratingWidget: RatingWidget(
                                                full: const Icon(Icons.star,
                                                    color: TColors.primary),
                                                half: const Icon(
                                                    Icons.star_half,
                                                    color: Colors.amber),
                                                empty: const Icon(
                                                    Icons.star_border,
                                                    color: TColors.grey),
                                              ),
                                              initialRating: 0.0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: false,
                                              itemCount: 5,
                                              itemSize: 40,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              onRatingUpdate: (ratting) {
                                                ratingController
                                                    .setRating(ratting);
                                              }),
                                          const SizedBox(
                                            height: TSizes.spaceBtwItems,
                                          ),
                                          TextField(
                                            decoration: const InputDecoration(
                                              hintText: 'Type your review here',
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: ratingController
                                                .reviewController,
                                          ),
                                          const SizedBox(
                                            height: TSizes.spaceBtwItems,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // submit review
                                                ratingController.postReview(
                                                    product.prodId, product);

                                                Get.back();
                                              },
                                              child: const Text('Submit'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: const Text('Write a review')),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        if (product.ratings!.isNotEmpty)
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: product.ratings!.length,
                            itemBuilder: (context, index) => UserReview(
                              rating:
                                  product.ratings![index]['rating'].toString(),
                              description:
                                  product.ratings![index]['detail'] ?? '',
                              userName:
                                  product.ratings![index]['userName'] ?? '',
                            ),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                          )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
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
}
