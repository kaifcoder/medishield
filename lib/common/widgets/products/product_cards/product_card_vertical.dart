import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/styles/shadow.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/controllers/wishlist_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/features/shop/screens/product_details/product_details.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/enums.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import '../../icons/t_circular_icon.dart';
import '../../text/price_text.dart';
import '../../text/product_title_text.dart';
import '../../text/t_brand_title_text.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final wishC = WishlistController.instance;
    final cart = CartController.instance;
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;
    // final salePercentage = controller.calculateSalePercentage(product!);
    final salePercentage = controller.calculateSalePercentage(product!);

    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product!,
          )),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.light,
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(children: [
                TRoundedImage(
                  imageUrl: (product!.thumbnailUrl.contains('http'))
                      ? product!.thumbnailUrl
                      : TTexts.imagebaseURL + product!.thumbnailUrl,
                  isNetworkImage: true,
                ),
                if (salePercentage > 0)
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      borderRadius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '${salePercentage.round()}% OFF',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ), // TRoundedContainer
                  ),
                if (AuthenticationRepository.instance.deviceStorage
                        .read('token') !=
                    null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Obx(
                      () => TCircularIcon(
                        onPressed: () => wishC.toggleWishlist(
                          product!.prodId,
                        ),
                        dark: dark,
                        icon: Iconsax.heart5,
                        color: wishC.isWishlisted(product!.prodId)
                            ? Colors.red
                            : TColors.darkGrey,
                      ),
                    ),
                  ),
                if (product!.isInStock == false)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: TRoundedContainer(
                      borderRadius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        'Out of Stock',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ), // TRoundedContainer
                  ),
              ]),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            /// -- Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(
                    title: product!.name,
                    smallSize: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleText(
                    title: product!.childProducts.length > 1
                        ? ProductModel.getManufacture(
                            product!.childProducts[0].manufacturer)
                        : ProductModel.getManufacture(product!.manufacturer),
                    maxLines: 1,
                    textColor: dark ? TColors.white : TColors.black,
                    textAlign: TextAlign.start,
                    brandTextSize: TextSizes.small,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: PriceText(
                      price: (product!.childProducts.length > 1)
                          ? 'Starts at ${product!.price.minimalPrice.toDouble() * rate} $ccy'
                          : '${product!.price.minimalPrice.toDouble() * rate} $ccy',
                      maxLines: 2,
                      isLarge: false,
                      isLineThrough: false,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          if (product!.childProducts.length > 1) {
                            Get.to(() => ProductDetailScreen(
                                  product: product!,
                                ));
                          } else {
                            cart.addToCart(
                                price: product!.price.minimalPrice,
                                product: product!.prodId,
                                count: 1,
                                v: product!.sku);
                          }
                        },
                        icon: Icon(
                            (product!.childProducts.length > 1)
                                ? Iconsax.arrow_right
                                : Iconsax.add,
                            color: TColors.white),
                      ),
                    ),
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
