import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/coupon_controller.dart';
import 'package:medishield/features/shop/screens/checkout/widget/horizontal_coupon_card.dart';

class CouponDialog extends StatelessWidget {
  const CouponDialog({super.key});
  bool isCouponValid(String expiryDateStr) {
    // Parse the expiry date string into a DateTime object
    DateTime expiryDate = DateTime.parse(expiryDateStr);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the current date is before the expiry date
    return currentDate.isBefore(expiryDate);
  }

  @override
  Widget build(BuildContext context) {
    // create a container for bottom sheet

    final couponController = Get.put(CouponController());
    final cartController = CartController.instance;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Available Coupons',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text("Tap on a coupon to apply it to your order."),
          const SizedBox(height: 10),
          Obx(() {
            if (couponController.loading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              height: 400,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: couponController.couponList.length,
                itemBuilder: (context, index) {
                  final coupon = couponController.couponList[index];
                  var valid = isCouponValid(coupon.expiryDate!);
                  debugPrint('Coupon Valid: $valid');
                  if (!valid) {
                    return const SizedBox();
                  }
                  return GestureDetector(
                    onTap: () {
                      cartController.coupon.value = coupon.couponCode!;
                      cartController.couponId.value = coupon.sId!;
                      cartController.couponApplied.value = true;
                      cartController.coupondiscount.value = coupon.discount!;
                      cartController.couponMsc.value =
                          coupon.minimumMedishieldCoins!;
                      cartController.handleCoupon();
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: HorizontalCoupon(
                        coupon: coupon,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
