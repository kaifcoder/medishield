import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

class OrderTracker extends StatelessWidget {
  const OrderTracker({super.key, required this.orderStatus, this.date = ''});

  final int orderStatus;
  final String date;

  @override
  Widget build(BuildContext context) {
    return OrderTrackerZen(
      tracker_data: [
        TrackerData(
          title: "Order Placed",
          date: date,
          tracker_details: [
            TrackerDetails(
              title: "Your order was placed",
              datetime: date,
            ),
          ],
        ),
        if (orderStatus >= 1)
          TrackerData(
            title: "Order Shipped",
            date: date,
            tracker_details: [
              TrackerDetails(
                title: "Your order was shipped",
                datetime: date,
              ),
            ],
          ),
        if (orderStatus == 2)
          TrackerData(
            title: "Order Delivered",
            date: date,
            tracker_details: [
              TrackerDetails(
                title: "Your order was delivered",
                datetime: date,
              ),
            ],
          ),
      ],
      isShrinked: true,
      success_color: TColors.primary,
    );
  }
}
