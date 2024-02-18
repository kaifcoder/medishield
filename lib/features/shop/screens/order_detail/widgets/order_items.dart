import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/features/shop/controllers/order_controller.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/constants/colors.dart';

import 'package:medishield/utils/constants/sizes.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.oindex});

  final int oindex;

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    final rate = LocationController.instance.rate;
    final ccy = LocationController.instance.currencyCode;
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
                      imageUrl: (controller.orderData[oindex].products[index]
                              .product.thumbnailUrl
                              .contains('http'))
                          ? controller.orderData[oindex].products[index].product
                              .thumbnailUrl
                          : 'https://images.dentalkart.com/media/catalog/product/${controller.orderData[oindex].products[index].product.thumbnailUrl}',
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
                              controller.orderData[oindex].products[index]
                                          .product.childProducts.length >
                                      1
                                  ? ProductModel.getManufacture(controller
                                      .orderData[oindex]
                                      .products[index]
                                      .product
                                      .childProducts[0]
                                      .manufacturer)
                                  : ProductModel.getManufacture(controller
                                      .orderData[oindex]
                                      .products[index]
                                      .product
                                      .manufacturer),
                              style: Theme.of(context).textTheme.labelMedium),
                          Text(
                              controller.orderData[oindex].products[index]
                                          .variant !=
                                      ''
                                  ? controller.orderData[oindex].products[index]
                                      .product.childProducts
                                      .map((e) => e.sku ==
                                              controller.orderData[oindex]
                                                  .products[index].variant
                                          ? e.name
                                          : controller.orderData[oindex]
                                              .products[index].product.name)
                                      .toString()
                                      .replaceAll('(', '')
                                      .replaceAll(')', '')
                                      .replaceAll(',', '')
                                      .trim()
                                  : controller.orderData[oindex].products[index]
                                      .product.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                '${controller.orderData[oindex].products[index].price * rate} $ccy x ${controller.orderData[oindex].products[index].count}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
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
                // quantity
              ],
            ),
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
        itemCount: controller.orderData[oindex].products.length);
  }
}
