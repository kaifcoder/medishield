import 'package:flutter/material.dart';
import 'package:medihealth/common/widgets/custom_shapes/containers/t_primary_header_container.dart';
import 'package:medihealth/utils/constants/colors.dart';
import 'package:medihealth/utils/constants/image_strings.dart';
import 'package:medihealth/utils/constants/sizes.dart';
import 'package:medihealth/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/custom_shapes/containers/t_search_container.dart';
import '../../../../common/widgets/image_text_widgets/t_vertical_image_text.dart';
import '../../../../common/widgets/text/t_section_heading.dart';
import 'widgets/t_home_app_bar.dart';

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
                  SizedBox(height: TSizes.spaceBtwSections),
                  //Search Bar
                  TSearchContainer(text: 'Search for products'),
                  SizedBox(height: TSizes.spaceBtwSections),
                  //Categories
                  Padding(
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
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return TVerticalImageText(
                                    title: 'Shoe category',
                                    image: TImages.sportIcon,
                                    textColor: TColors.white,
                                    onTap: () {});
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
