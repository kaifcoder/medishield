import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/styles/shadow.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/common/widgets/icons/t_circular_icon.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/common/widgets/text/price_text.dart';
import 'package:medishield/common/widgets/text/product_title_text.dart';
import 'package:medishield/common/widgets/text/t_brand_title_text.dart';
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

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal(
      {super.key, this.product, required this.isLoadMore});

  final ProductModel? product;
  final bool isLoadMore;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final wishC = WishlistController.instance;
    final salePercentage = controller.calculateSalePercentage(product!);
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;
    final cart = CartController.instance;
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product!,
          )),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.horizontalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: TColors.light,
        ),
        child: Row(
          children: [
            // image
            TRoundedContainer(
              height: 120,
              width: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: TColors.light,
              child: Stack(children: [
                TRoundedImage(
                  backgroundColor: TColors.light,
                  imageUrl: (product!.thumbnailUrl.contains('http'))
                      ? product!.thumbnailUrl
                      : 'https://images.dentalkart.com/media/catalog/product/${product!.thumbnailUrl}',
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
              ]),
            ),
            // title, brand, price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ProductTitleText(
                          title: product!.name,
                          smallSize: false,
                          maxLines: 2,
                        ),
                      ),
                      if (AuthenticationRepository.instance.deviceStorage
                              .read('token') !=
                          null)
                        Obx(
                          () => TCircularIcon(
                            onPressed: () => wishC.toggleWishlist(
                              product!.prodId,
                            ),
                            icon: Iconsax.heart5,
                            color: wishC.isWishlisted(product!.prodId)
                                ? Colors.red
                                : TColors.darkGrey,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  TBrandTitleText(
                    title: product!.childProducts.length > 1
                        ? ProductModel.getManufacture(
                            product!.childProducts[0].manufacturer)
                        : ProductModel.getManufacture(product!.manufacturer),
                    maxLines: 1,
                    textColor: TColors.black,
                    textAlign: TextAlign.start,
                    brandTextSize: TextSizes.small,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: PriceText(
                          price: (product!.childProducts.length > 1)
                              ? 'Starts at ${product!.price.minimalPrice.toDouble() * rate} $ccy'
                              : '${product!.price.minimalPrice.toDouble() * rate} $ccy',
                          maxLines: 1,
                          isLarge: false,
                          isLineThrough: false,
                        ),
                      ),
                      if (product!.childProducts.length == 1)
                        Container(
                          decoration: const BoxDecoration(
                            color: TColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(TSizes.productImageRadius),
                            ), // BorderRadius.only
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
                                icon: const Icon(Iconsax.add,
                                    color: TColors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
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
