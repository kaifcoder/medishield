import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/images/t_rounded_image.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //image
                  children: [
                    TRoundedImage(
                      imageUrl: TImages.productImage20,
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
                          Text('Brand name',
                              style: Theme.of(context).textTheme.labelMedium),
                          Text('Product sdfadfas asdfas namejssdfasdfasd',
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                '₹ 100',
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
        separatorBuilder: (_, __) => SizedBox(
              height: TSizes.spaceBtwItems,
            ),
        itemCount: 4);
  }
}
