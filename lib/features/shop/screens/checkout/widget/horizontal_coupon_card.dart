import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:medishield/features/shop/models/coupon_model.dart';
import 'package:medishield/utils/constants/colors.dart';

class HorizontalCoupon extends StatelessWidget {
  const HorizontalCoupon({super.key, required this.coupon});
  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = TColors.accent;
    const Color secondaryColor = Color.fromARGB(255, 34, 48, 116);
    var expiryDate = coupon.expiryDate!.split('T')[0];
    expiryDate = expiryDate.split('-').reversed.join('-');
    return CouponCard(
      height: 120,
      backgroundColor: primaryColor,
      curveAxis: Axis.vertical,
      firstChild: Container(
        decoration: const BoxDecoration(
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      coupon.type == 'percentage'
                          ? '${coupon.discount}%'
                          : '₹${coupon.discount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.white54, height: 0),
          ],
        ),
      ),
      secondChild: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'Coupon Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Spacer(),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              coupon.couponCode!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              'Valid Till - $expiryDate',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
