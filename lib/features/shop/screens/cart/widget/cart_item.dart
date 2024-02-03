import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/models/cart_model.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.showQuantity, this.product});

  final bool showQuantity;
  final List<Products>? product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    if (product!.isEmpty) return const Center(child: Text('No items in cart'));
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //image
            children: [
              TRoundedImage(
                isNetworkImage: true,
                imageUrl:
                    'https://images.dentalkart.com/media/catalog/product/${product![index].product.thumbnailUrl}',
                height: 80,
                width: 80,
                padding: EdgeInsets.all(TSizes.xs),
                backgroundColor: TColors.grey,
              ),
              // brand
              // name
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product![index].product.name.split(' ')[0],
                        style: Theme.of(context).textTheme.labelMedium),
                    Text(
                        controller.userCart.value.products[index].variant != ''
                            ? product![index]
                                .product
                                .childProducts
                                .map((e) => e.sku == product![index].variant
                                    ? e.name
                                    : '')
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .replaceAll(',', '')
                                .trim()
                            : product![index].product.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    Row(
                      children: [
                        if (showQuantity)
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.removeFromCart(
                                      product: product![index].product.prodId,
                                      count:
                                          product![index].count == 1 ? -1 : 1,
                                      price: product![index].price,
                                      v: product![index].variant,
                                    );
                                  },
                                  icon: const Icon(Iconsax.minus)),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              Text(
                                product![index].count.toString() ?? '0',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(color: TColors.black),
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.addToCart(
                                    product: product![index].product.prodId,
                                    count: 1,
                                    price: product![index].price,
                                    v: product![index].variant,
                                  );
                                },
                                icon: const Icon(Iconsax.add),
                              ),
                            ],
                          ),
                        const Spacer(),
                        Text(
                          '₹ ${product![index].price * product![index].count}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // price
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
        ],
      ),
      separatorBuilder: (_, __) => const SizedBox(
        height: TSizes.spaceBtwItems,
      ),
      itemCount: product!.length,
    );
  }
}
