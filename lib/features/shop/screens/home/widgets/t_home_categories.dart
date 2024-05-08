import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/image_text_widgets/t_vertical_image_text.dart';
import 'package:medishield/common/widgets/shimmers/category_shimmer.dart';
import 'package:medishield/features/shop/controllers/all_product_controller.dart';
import 'package:medishield/features/shop/controllers/category_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/view_all_products/all_product.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final images = [
      TImages.endodontics,
      TImages.generalDentistry,
      TImages.instruments,
      TImages.pharmacy,
      TImages.orthodontics,
      TImages.restorative,
    ];

    final controller = Get.put(CategoryController());
    final all = Get.put(AllProductController());
    final productController = ProductController.instance;

    return SizedBox(
      height: 80,
      child: Obx(() {
        if (controller.categoryLoading.value) return const CategoryShimmer();
        if (controller.categoryList.isEmpty) {
          return Center(
            child: Text(
              'No Categories found',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.featuredCategory.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return TVerticalImageText(
                title: controller.featuredCategory[index].name,
                image: images[index],
                textColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.dark
                    : TColors.light,
                onTap: () async {
                  await productController.fetchProductsbycategory(
                      controller.featuredCategory[index].name, 1);
                  all.setTitle(controller.featuredCategory[index].name);
                  all.reset();
                  Get.to(
                    () => AllProductScreen(
                      title: controller.featuredCategory[index].name,
                      product: productController.CategoryProducts,
                    ),
                  );
                });
          },
        );
      }),
    );
  }
}
