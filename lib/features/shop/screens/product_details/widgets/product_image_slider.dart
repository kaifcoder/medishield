import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/appbar/appbar.dart';
import 'package:medishield/common/widgets/custom_shapes/curved_edges/t_curved_edge_widget.dart';
import 'package:medishield/common/widgets/icons/t_circular_icon.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/common/widgets/products/cart/t_cart_counter_icon.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/shop/controllers/images_controller.dart';
import 'package:medishield/features/shop/controllers/wishlist_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/features/shop/screens/cart/cart.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widget_zoom/widget_zoom.dart';

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
                      return CarouselSlider(
                        items: images.map((image) {
                          return WidgetZoom(
                            heroAnimationTag: product.prodId,
                            zoomWidget: CachedNetworkImage(
                              imageUrl: images[images
                                  .indexOf(controller.selectedImage.value)],
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.contain,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            controller.selectedImage.value = images[index];
                          },
                          height: 400,
                          viewportFraction: 1,
                          initialPage: 0,
                          reverse: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                        ),
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
                const SizedBox(
                  width: 10,
                ),
                TCircularIcon(
                  onPressed: () => {
                    Share.share(
                        """Check out this product on MediShield: ${product.name}\nPrice: ${product.price.minimalPrice}\nlink: https://medishield-admin-two.vercel.app/product/${product.prodId}""")
                  },
                  dark: dark,
                  icon: Icons.share,
                  color: TColors.darkGrey,
                ),
                TCartCounterIcon(
                  iconColor: TColors.black,
                  onPressed: () {
                    if (AuthenticationRepository.instance.deviceStorage
                            .read('guest') ==
                        true ||  AuthenticationRepository.instance.deviceStorage.read('token') == null) {
                      Get.offAll(() => const LoginScreen());
                    } else {
                      Get.to(() => const CartScreen());
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
