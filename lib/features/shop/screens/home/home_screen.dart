import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/t_primary_header_container.dart';
import 'package:medihealth/common/widgets/products/product_cards/product_card_vertical.dart';

import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/image_strings.dart';
import 'package:medihealth/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/t_search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/text/t_section_heading.dart';
import 'widgets/t_home_app_bar.dart';
import 'widgets/t_home_categories.dart';
import 'widgets/t_promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  //Search Bar
                  TSearchContainer(
                    text: 'Search for products',
                    onTap: () {},
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  //Categories
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: 'Popular Categories',
                          color: TColors.light,
                          buttonTitle: 'View All',
                          showButton: true,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        THomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///body

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  GridLayout(
                    itemBuilder: (_, index) => const ProductCardVertical(),
                    itemCount: 4,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
