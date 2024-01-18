import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/t_primary_header_container.dart';
import 'package:medihealth/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:medihealth/features/shop/screens/Search/Search.dart';
import 'package:medihealth/features/shop/screens/categories/categories.dart';

import 'package:medihealth/utils/constants/image_strings.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/device/device_utility.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: TDeviceUtils.getAppBarHeight() + 120,
        flexibleSpace: TPrimaryHeaderContainer(
          child: Column(
            children: [
              const THomeAppBar(),
              const SizedBox(height: TSizes.spaceBtwSections / 1.5),
              //Search Bar
              TSearchContainer(
                text: 'Search for products',
                onTap: () => Get.to(() => const SearchScreen()),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: TDeviceUtils.getAppBarHeight() + 120),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///body
              /// //Categories
              Padding(
                padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  children: [
                    SizedBox(height: TSizes.spaceBtwSections),
                    TSectionHeading(
                      title: 'Popular Categories',
                      buttonTitle: 'View All',
                      showButton: true,
                      onButtonPressed: () => Get.to(
                        () => CategoiesScreen(),
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    THomeCategories(),
                  ],
                ),
              ),

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
                    TSectionHeading(
                      title: 'Trending Products',
                      buttonTitle: 'View All',
                      showButton: true,
                      onButtonPressed: () {},
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
      ),
    );
  }
}
