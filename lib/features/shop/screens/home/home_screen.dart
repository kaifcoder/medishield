import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/t_primary_header_container.dart';
import 'package:medishield/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:medishield/common/widgets/shimmers/product_shimmer.dart';
import 'package:medishield/features/shop/controllers/all_product_controller.dart';
import 'package:medishield/features/shop/controllers/banner_controller.dart';
import 'package:medishield/features/shop/controllers/home_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/categories/categories.dart';
import 'package:medishield/features/shop/screens/chat/chat.dart';
import 'package:medishield/features/shop/screens/view_all_products/all_product.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/device/device_utility.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/text/t_section_heading.dart';

import 'widgets/t_home_app_bar.dart';
import 'widgets/t_home_categories.dart';
import 'widgets/t_promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final controller = Get.put(ProductController());
    final bannerController = Get.put(BannerController());
    final productController = ProductController.instance;
    final allProductController = Get.put(AllProductController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: TDeviceUtils.getAppBarHeight() + 30,
        flexibleSpace: const TPrimaryHeaderContainer(
          child: Column(
            children: [
              THomeAppBar(),
              SizedBox(height: TSizes.spaceBtwSections / 1.5),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: TDeviceUtils.getAppBarHeight() + 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  children: [
                    // if ios increase the space between sections
                    if (!TDeviceUtils.isIOS())
                      const SizedBox(height: TSizes.spaceBtwSections),
                    if (TDeviceUtils.isIOS())
                      const SizedBox(height: TSizes.spaceBtwSections * 1.5),
                    TSectionHeading(
                      title: 'Popular Categories',
                      buttonTitle: 'View All',
                      showButton: true,
                      onButtonPressed: () => Get.to(
                        () => const CategoiesScreen(),
                      ),
                    ),
                    const THomeCategories(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlider(
                      skipCount: 0,
                      takeCount: 6,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(() {
                      if (controller.offerProducts.isEmpty) {
                        return const SizedBox();
                      }
                      return TSectionHeading(
                        title: 'Offer Zone',
                        buttonTitle: 'View All',
                        showButton: true,
                        onButtonPressed: () async {
                          await productController.fetchProductsbycategory(
                              'Offers', 1);
                          allProductController.setTitle('Offers Zone');
                          allProductController.reset();
                          Get.to(
                            () => AllProductScreen(
                              title: 'Offer Zone',
                              product: productController.offerProducts,
                            ),
                          );
                        },
                      );
                    }),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const ProductShimmer();
                        }
                        if (controller.offerProducts.isNotEmpty) {
                          return GridLayout(
                            itemBuilder: (_, index) => ProductCardVertical(
                              product: controller.offerProducts[index],
                            ),
                            itemCount: controller.offerProducts.length,
                          );
                        }
                        return const Text('');
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(
                      title: 'Featured Products',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const ProductShimmer();
                        }
                        if (controller.FeaturedProducts.isEmpty) {
                          return const Center(
                            child: Text('0 Products Available Right Now'),
                          );
                        }
                        return GridLayout(
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.FeaturedProducts[index],
                          ),
                          itemCount: controller.FeaturedProducts.length,
                        );
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TPromoSlider(
                      skipCount: 6,
                      takeCount: (bannerController.totalBanners.value - 6) > 6
                          ? 6
                          : bannerController.totalBanners.value - 6,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(
                      title: 'Endocraft Products',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const ProductShimmer();
                        }
                        if (controller.Endodontics.isEmpty) {
                          return const Center(
                            child: Text('No data found'),
                          );
                        }
                        return GridLayout(
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.Endodontics[index],
                          ),
                          itemCount: controller.Endodontics.length,
                        );
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    ///

                    const TSectionHeading(
                      title: 'Medishield Products',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const ProductShimmer();
                        }
                        if (controller.Orthodontics.isEmpty) {
                          return const Center(
                            child: Text('No data found'),
                          );
                        }
                        return GridLayout(
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.Orthodontics[index],
                          ),
                          itemCount: controller.Orthodontics.length,
                        );
                      },
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    ///
                    TPromoSlider(
                      skipCount: 6 * 2,
                      // take all remaining items
                      takeCount: bannerController.totalBanners.value - (6 * 2),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(
                      title: 'Clinician\'s Choice Products',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const ProductShimmer();
                        }
                        if (controller.Instruments.isEmpty) {
                          return const Center(
                            child: Text('0 Products Available Right Now'),
                          );
                        }
                        return GridLayout(
                          itemBuilder: (_, index) => ProductCardVertical(
                            product: controller.Instruments[index],
                          ),
                          itemCount: controller.Instruments.length,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () {
          Get.to(() => const ChatScreen(),
              transition: Transition.cupertinoDialog,
              curve: Curves.easeInOutCubic);
        },
        child: const Icon(
          Iconsax.message,
          color: Colors.white,
        ),
      ),
    );
  }
}
