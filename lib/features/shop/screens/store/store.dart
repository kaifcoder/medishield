import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/t_search_container.dart';
import 'package:medishield/common/widgets/layouts/grid_layout.dart';
import 'package:medishield/common/widgets/products/cart/t_cart_counter_icon.dart';
import 'package:medishield/common/widgets/tabbar/tabbar.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/shop/controllers/brand_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/Search/Search.dart';
import 'package:medishield/features/shop/screens/brands/all_brands.dart';
import 'package:medishield/features/shop/screens/cart/cart.dart';
import 'package:medishield/features/shop/screens/view_all_products/all_product.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

import 'widgets/brand_card.dart';
import 'widgets/t_category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    final productController = ProductController.instance;
    return DefaultTabController(
      length: 15,
      child: Scaffold(
        appBar: TAppBar(
          title: Column(
            children: [
              Text(
                'Store',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
            ],
          ),
          actions: [
            TCartCounterIcon(
                iconColor: TColors.black,
                onPressed: () => Get.to(() => const CartScreen()))
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: false,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  expandedHeight: 400,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        TSearchContainer(
                          text: 'Search for products',
                          showBackgroud: false,
                          showBorder: true,
                          padding: EdgeInsets.zero,
                          onTap: () => Get.to(() => const SearchScreen()),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        TSectionHeading(
                          title: 'Featured Brands',
                          showButton: true,
                          onButtonPressed: () =>
                              Get.to(() => const AllBrandScreen()),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 1.5,
                        ),
                        Obx(
                          () => GridLayout(
                              mainAxisExtent: 80,
                              itemCount: controller.featuredBrand.length,
                              itemBuilder: (context, index) {
                                return BrandCard(
                                    title: controller.featuredBrand[index].name,
                                    image: controller.featuredBrand[index].logo,
                                    isNetworkImage: true,
                                    onPressed: () async {
                                      await productController
                                          .fetchProductsbycategory(controller
                                              .featuredBrand[index].name);

                                      Get.to(
                                        () => AllProductScreen(
                                          title: controller
                                              .featuredBrand[index].name,
                                          product: productController
                                              .CategoryProducts,
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                  bottom: const TabBarCustom(tabs: [
                    Tab(
                      text: 'Pharmacy',
                    ),
                    Tab(
                      text: 'General Dentistry',
                    ),
                    Tab(
                      text: 'Equipments',
                    ),
                    Tab(
                      text: 'Hand Sanitizer',
                    ),
                    Tab(
                      text: 'Restorative',
                    ),
                    Tab(
                      text: 'Endodontics',
                    ),
                    Tab(
                      text: 'Orthodontics',
                    ),
                    Tab(
                      text: 'Paedodontics',
                    ),
                    Tab(
                      text: 'Prosthodontics',
                    ),
                    Tab(
                      text: 'Oral Surgery',
                    ),
                    Tab(
                      text: 'Periodontics',
                    ),
                    Tab(
                      text: 'Instruments',
                    ),
                    Tab(
                      text: 'Implantology',
                    ),
                    Tab(
                      text: 'Sterialization',
                    ),
                    Tab(
                      text: 'New Clinical Setup Kits',
                    ),
                  ]),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
              ],
            )),
      ),
    );
  }
}
