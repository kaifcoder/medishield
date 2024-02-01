import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/bottom_add_to_cartbar.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/product_variants.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/qa_widget.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/t_rating_bar_indicator.dart';
import 'package:medishield/features/shop/screens/product_details/widgets/user_review.dart';
import 'package:medishield/utils/constants/sizes.dart';

import 'widgets/overall_product_rating.dart';
import 'widgets/product_image_slider.dart';
import 'widgets/review_text.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, this.id = 0, this.product});

  final int id;
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product images carousel
            const ProductImageSlider(),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: Column(
                children: [
                  const ReviewText(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ProductMetaData(
                    title: product!.name,
                    shortDescription: product!.shortDescription,
                    manufacturer: 'Manufacturer',
                    price: product!.price.maximalPrice.toDouble(),
                    originalPrice: product!.price.maximalPrice.toDouble() * 2,
                    discount: product!.price.minimalPrice.toDouble(),
                    child: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const ChildProductDisplay(
                    selected: true,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const ChildProductDisplay(
                    selected: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout'),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      initiallyExpanded: true,
                      title: const Text('Description'),
                      children: [
                        Html(
                            data:
                                '''${product!.productSpecs['description']}'''),
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Key Specification'),
                      children: [
                        Html(
                            data:
                                '''${product!.productSpecs['key_specifications']}'''),
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Packaging'),
                      children: [
                        Html(data: '''${product!.productSpecs['packaging']}'''),
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Direction To Use'),
                      children: [
                        Html(
                            data:
                                '''${product!.productSpecs['direction_to_use']}''')
                      ]),
                  ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Features'),
                      children: [
                        Html(data: '''${product!.productSpecs['features']}'''),
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
                            ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => QnA(
                                    index: index + 1,
                                    question: product!.qaData[index].question,
                                    answer: product!.qaData[index].answer),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: TSizes.sm,
                                      child: Divider(),
                                    ),
                                itemCount: 5),
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
                  const TSectionHeading(
                    title: 'Reviews (233)',
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OverallProductRating(),
                      const TRatingBarIndicator(rating: 4.5),
                      const Text('1,100'),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) => const UserReview(),
                        separatorBuilder: (context, index) => const Divider(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            // variant if any

            // product description
            //features collapisble

            // product reviews
          ],
        ),
      ),
      bottomNavigationBar: const BottomAddToCartBar(),
    );
  }
}
