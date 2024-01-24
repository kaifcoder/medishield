import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
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
  const ProductDetailScreen({super.key});

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
                  const ProductMetaData(
                    title: 'Product Name',
                    shortDescription: 'Product short description',
                    manufacturer: 'Manufacturer',
                    price: 100,
                    originalPrice: 200,
                    discount: 50,
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
                              '''<p><strong>iDENTical Silicone Suture Practice Pad with 14 Pre-cuts</strong></p>\r\n<p>An iDENTical silicone suture practice pad with 14 pre-cuts refers to a training tool used by medical professionals, particularly those studying or practicing suturing techniques.This pad is made of silicone, which closely mimics human tissue in terms of texture and flexibility, providing a realistic suturing experience. The pad is designed with pre-cut incisions or wounds in various shapes and sizes. These pre-cuts serve as practice areas where medical students or professionals can practice their suturing skills. The 14 pre-cuts indicate that the pad has 14 different incisions, offering a range of practice scenarios for learners.By using this silicone suture practice pad, individuals can learn and improve their suturing techniques without the need for live patients. It allows users to practice different types of sutures, such as simple interrupted sutures, continuous sutures, or more complex techniques like subcuticular sutures.</p>\r\n<p><strong>Indications:</strong></p>\r\n<ul>\r\n<li><strong>Medical Education:</strong> The practice pad is primarily used in medical education and training settings, such as medical schools, nursing programs, and surgical training programs. It provides a safe and controlled environment for students to learn and practice suturing techniques before applying them to real patients.</li>\r\n<li><strong>Skill Development:</strong> The practice pad allows medical professionals to develop and refine their suturing skills. By repeatedly practicing on the silicone pad, individuals can improve their hand-eye coordination, dexterity, and technique, leading to more proficient suturing abilities.</li>\r\n<li><strong>Suture Technique Variation:</strong> The pad's pre-cut wounds offer a range of scenarios for practicing different suture techniques. Users can practice different types of sutures, explore various closure methods, and learn how to adapt their approach based on the wound's characteristics.</li>\r\n<li><strong>Confidence Building:</strong> Using a practice pad helps build confidence in suturing abilities. As individuals gain experience and proficiency on the pad, they develop the confidence to perform sutures on real patients, reducing anxiety and improving patient care.</li>\r\n<li><strong>Refresher Training:</strong> Experienced medical professionals can use the practice pad as a refresher tool to brush up on their suturing skills. It allows them to stay proficient in suturing techniques, especially if they do not frequently encounter suturing procedures in their practice.</li>\r\n<li><strong>Independent Practice:</strong> The silicone pad provides a convenient way for individuals to practice suturing independently outside of formal training programs. It can be used by healthcare professionals who want to improve their skills or by aspiring medical students seeking to gain exposure and practice before entering medical school.</li>\r\n</ul>
                          ''',
                        ),
                      ]),
                  const ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Key Specification'),
                      children: [
                        Text(
                          'data',
                        ),
                      ]),
                  const ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Packaging'),
                      children: [
                        Text(
                          'data',
                        ),
                      ]),
                  const ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Direction To Use'),
                      children: [
                        Text(
                          'data',
                        ),
                      ]),
                  const ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text('Warranty'),
                      children: [
                        Text(
                          'data',
                        ),
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
                                    question: 'Question',
                                    answer: 'Answer'),
                                separatorBuilder: (context, index) => const SizedBox(
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
