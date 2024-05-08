import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/common/widgets/icons/t_circular_icon.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/product_variants_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class BottomAddToCartBar extends StatelessWidget {
  const BottomAddToCartBar({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final varient = ProductVariantsController.instance;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: const BoxDecoration(
        color: TColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.darkGrey,
                color: TColors.white,
                height: 40,
                width: 40,
                onPressed: () {
                  controller.decreaseCount();
                },
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Obx(
                () => Text(
                  controller.counter.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: TColors.black),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                color: TColors.white,
                height: 40,
                width: 40,
                onPressed: () {
                  controller.increaseCount();
                },
              ),
            ],
          ),

          //add to cart button
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  ),
                  side: const BorderSide(color: TColors.black)),
              onPressed: () {
                if (product.childProducts.length <= 1 &&
                    product.isInStock == false) {
                  CustomSnackbar.warningSnackBar('Product is out of stock.');
                  return;
                }
                if (product.childProducts.length > 1 &&
                    varient.selectedVariantIndex.value == -1) {
                  CustomSnackbar.warningSnackBar('Please select a variant');
                  return;
                }
                if (product.childProducts.length > 1 &&
                    product.childProducts[varient.selectedVariantIndex.value]
                            .isInStock ==
                        false) {
                  CustomSnackbar.warningSnackBar(
                      'Selected variant is out of stock');
                  return;
                }
                controller.addToCart(
                  product: product.prodId,
                  count: controller.counter.value,
                  price: product.childProducts.length > 1
                      ? product
                                  .childProducts[
                                      varient.selectedVariantIndex.value]
                                  .price
                                  .minimalPrice ==
                              0
                          ? product
                              .childProducts[varient.selectedVariantIndex.value]
                              .specialPrice!
                          : product
                              .childProducts[varient.selectedVariantIndex.value]
                              .price
                              .minimalPrice
                      : product.price.minimalPrice,
                  v: product.childProducts.length > 1
                      ? product
                          .childProducts[varient.selectedVariantIndex.value].sku
                      : product.sku,
                );
              },
              child: Text(product.isInStock ? 'Add to cart' : 'Out of stock'))
        ],
      ),
    );
  }
}
