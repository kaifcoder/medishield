import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/t_circular_container.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/common/widgets/loaders/custom_shimmer.dart';
import 'package:medishield/features/shop/controllers/banner_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/product_details/product_details.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key, required this.skipCount});
  final int skipCount;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const CustomShimmer(height: 190, width: double.infinity);
      }
      return Column(
        children: [
          CarouselSlider(
            items: controller.bannerList
                .toList()
                .skip(skipCount)
                .take(3)
                .map(
                  (banner) => TRoundedImage(
                    onPressed: () async {
                      await ProductController.instance
                          .getProductById(banner.id);
                      Get.to(
                          () => ProductDetailScreen(
                                product: ProductController
                                    .instance.CategoryProducts.last,
                              ),
                          transition: Transition.cupertinoDialog);
                    },
                    imageUrl: banner.mobileImage,
                    isNetworkImage: true,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Center(
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 3; i++)
                    TCircularContainer(
                      height: 4,
                      width: 20,
                      backgroundColor: controller.carouselIndex.value == i
                          ? TColors.primary
                          : TColors.grey,
                      margin: const EdgeInsets.only(right: 10),
                    )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
