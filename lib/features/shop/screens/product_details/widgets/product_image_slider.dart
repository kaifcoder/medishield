import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/curved_edges/t_curved_edge_widget.dart';
import 'package:medishield/common/widgets/icons/t_circular_icon.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/features/shop/controllers/images_controller.dart';
import 'package:medishield/features/shop/controllers/wishlist_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    final wishc = WishlistController.instance;
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(
                    child: Obx(() {
                      final image = controller.selectedImage.value;
                      return CachedNetworkImage(
                        imageUrl: image,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.contain,
                      );
                    }),
                  )),
            ),
            Positioned(
              right: 5,
              bottom: 30,
              left: TSizes.sm,
              child: SizedBox(
                height: 60,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Obx(
                          () => TRoundedImage(
                            onPressed: () {
                              controller.selectedImage.value = images[index];
                            },
                            width: 60,
                            border: Border.all(
                              color: controller.selectedImage.value ==
                                      images[index]
                                  ? TColors.primary
                                  : TColors.grey,
                            ),
                            backgroundColor:
                                dark ? TColors.dark : TColors.light,
                            padding: const EdgeInsets.all(TSizes.sm / 2),
                            imageUrl: images[index],
                            isNetworkImage: true,
                          ),
                        ),
                    separatorBuilder: (_, __) => const SizedBox(
                          width: TSizes.spaceBtwItems / 2,
                        ),
                    itemCount: images.length),
              ),
            ),
            TAppBar(
              showBackArrow: true,
              actions: [
                Obx(
                  () => TCircularIcon(
                    onPressed: () => wishc.toggleWishlist(
                      product.prodId,
                    ),
                    dark: dark,
                    icon: Iconsax.heart5,
                    color: wishc.isWishlisted(product.prodId)
                        ? Colors.red
                        : TColors.darkGrey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
