// create getx controller for coupons
// Path: lib/features/shop/controllers/coupon_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/personalization/controllers/user_controller.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/models/coupon_model.dart';
import 'package:medishield/utils/http/http_client.dart';

class CouponController extends GetxController {
  static CouponController get instance => Get.find();
  final controller = CartController.instance;
  final coupon = ''.obs;
  final couponId = ''.obs;
  final discount = 0.obs;
  final couponApplied = false.obs;
  var couponList = <Coupon>[].obs;
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllCouponsforuser();
  }

  void getAllCouponsforuser() async {
    // fetch all coupons from the server and filter for the user according to cart value and msc.
    try {
      loading.value = true;
      final res = await THttpHelper.get('api/coupon/');
      debugPrint('Coupon Data: ${res['data']}');
      if (res['data'] != null) {
        couponList.clear();
        for (final item in res['data']) {
          if (item['minimumCartValue'] != null &&
              item['minimumMedishieldCoins'] != null &&
              item['minimumCartValue'] <= controller.total.value.toInt() &&
              item['minimumMedishieldCoins'] <=
                  UserController.instance.user.value.medishieldcoins!) {
            couponList.add(Coupon.fromJson(item));
          }
        }

        loading.value = false;
        update();
      }
      // filter coupons for the user according to cart value and msc
    } catch (e) {
      loading.value = false;
      debugPrint('Error: ${e.toString()}');
    }
  }
}
