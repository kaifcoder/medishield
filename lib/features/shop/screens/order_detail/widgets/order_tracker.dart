import 'package:flutter/material.dart';
import 'package:medishield/utils/constants/colors.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';

class OrderTracker extends StatelessWidget {
  const OrderTracker(
      {super.key,
      required this.orderStatus,
      this.date = '',
      required this.trackingNumber});

  final int orderStatus;
  final String date;
  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
    debugPrint('Order Status: $trackingNumber');
    debugPrint('Order Status: $orderStatus');
    return OrderTrackerZen(
      tracker_data: [
        TrackerData(
          title: "Order Placed",
          date: date,
          tracker_details: [
            TrackerDetails(
              title: "Your Order is in Processing stay tuned for updates",
              datetime: date,
            ),
          ],
        ),
        if (orderStatus == 1)
          TrackerData(
            title: "Order Shipped",
            date: date,
            tracker_details: [
              TrackerDetails(
                title:
                    "Your order was shipped and is on the way here is your tracking number $trackingNumber",
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
        if (orderStatus == 3)
          TrackerData(
            title: "Order Cancelled",
            date: date,
            tracker_details: [
              TrackerDetails(
                title: "Your order was cancelled",
                datetime: date,
              ),
            ],
          ),
      ],
      isShrinked: false,
      success_color: TColors.primary,
    );
  }
}
