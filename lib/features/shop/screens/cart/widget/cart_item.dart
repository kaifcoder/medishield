import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/features/shop/models/cart_model.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/constants/text_strings.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.showQuantity, this.product});

  final bool showQuantity;
  final List<Products>? product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;
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
                    (product![index].product.thumbnailUrl.contains('http'))
                        ? product![index].product.thumbnailUrl
                        : TTexts.imagebaseURL +
                            product![index].product.thumbnailUrl,
                height: 80,
                width: 80,
                padding: const EdgeInsets.all(TSizes.xs),
                backgroundColor: TColors.grey,
              ),
              // brand
              // name
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        product![index].product.childProducts.length > 1
                            ? ProductModel.getManufacture(product![index]
                                .product
                                .childProducts[0]
                                .manufacturer)
                            : ProductModel.getManufacture(
                                product![index].product.manufacturer),
                        style: Theme.of(context).textTheme.labelMedium),
                    Text(
                        product![index].product.childProducts.length > 1
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
                              const Text('Qty: '),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: TSizes.spaceBtwItems / 2),
                                child: DropdownButton(
                                    icon: const Icon(Iconsax.arrow_down),
                                    iconSize: 16,
                                    menuMaxHeight: 300,
                                    alignment: Alignment.bottomCenter,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!,
                                    elevation: 2,
                                    isDense: true,
                                    hint:
                                        Text(product![index].count.toString()),
                                    items: List.generate(
                                      100,
                                      (index) => DropdownMenuItem(
                                        alignment: Alignment.center,
                                        value: index + 1,
                                        child: Text(
                                          (index + 1).toString(),
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      controller.addToCart(
                                        product: product![index].product.prodId,
                                        count: value! - product![index].count,
                                        price: product![index].price,
                                        v: product![index].variant,
                                      );
                                    }),
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.removeFromCart(
                                      product: product![index].product.prodId,
                                      count: -product![index].count,
                                      price: product![index].price,
                                      v: product![index].variant,
                                    );
                                  },
                                  icon: const Icon(Iconsax.trash)),
                            ],
                          ),
                        const Spacer(),
                        if (showQuantity)
                          Text(
                            '${product![index].price.toDouble() * product![index].count * rate} $ccy',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(fontSizeFactor: 0.8),
                          ),
                        if (!showQuantity)
                          Text(
                            '${product![index].price.toDouble() * rate} $ccy x ${product![index].count} =  ${product![index].price.toDouble() * product![index].count * rate} $ccy',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .apply(
                                  fontSizeFactor: 0.8,
                                ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
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
