import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/appbar/appbar.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/t_search_container.dart';
import 'package:medihealth/common/widgets/layouts/grid_layout.dart';
import 'package:medihealth/common/widgets/products/cart/t_cart_counter_icon.dart';
import 'package:medihealth/common/widgets/tabbar/tabbar.dart';
import 'package:medihealth/common/widgets/text/t_section_heading.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';

import 'widgets/brand_card.dart';
import 'widgets/t_category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            TCartCounterIcon(iconColor: TColors.black, onPressed: () {})
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const TSearchContainer(
                          text: 'Search for products',
                          showBackgroud: false,
                          showBorder: true,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        TSectionHeading(
                          title: 'Featured Brands',
                          showButton: true,
                          onButtonPressed: () {},
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 1.5,
                        ),
                        GridLayout(
                            mainAxisExtent: 80,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return const BrandCard();
                            }),
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
