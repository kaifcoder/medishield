import 'package:flutter/material.dart';
import 'package:medishield/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:medishield/utils/constants/colors.dart';

class TOrderCard extends StatelessWidget {
  const TOrderCard(
      {super.key,
      required this.orderNumber,
      required this.orderDate,
      required this.orderStatus,
      required this.orderAmount,
      required this.onTap,
      required this.name,
      required this.count});

  final String orderNumber;
  final String orderDate;
  final String name;
  final String orderStatus;
  final String orderAmount;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: TColors.lightGrey,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  orderNumber,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                      backgroundColor: TColors.primary,
                      alignment: Alignment.center),
                  onPressed: onTap,
                  child: Text(
                    'View Details',
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                        color: TColors.white, fontStyle: FontStyle.normal),
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Order Date: ${DateTime.parse(orderDate).toLocal().toString().split(' ')[0]}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '$name...',
            style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: TColors.darkerGrey,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            orderStatus,
            style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: TColors.primary,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Total Price: $orderAmount',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 6,
          ),
          Text('Number of items in the order: $count',
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
