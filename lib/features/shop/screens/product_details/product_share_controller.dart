import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';
import 'package:medishield/features/shop/screens/home/home_screen.dart';
import 'package:medishield/features/shop/screens/product_details/product_details.dart';

class ProductShareController extends GetxController {
  static ProductShareController get instance => Get.find();
  final controller = Get.put(ProductController());
  final isLoading = false.obs;
  var pId = ''.obs;

  @override
  void onReady() {
    fetchshare();
    super.onReady();
  }

  void fetchshare() async {
    final productId = Get.parameters['id'];
    debugPrint('id: $productId');
    if (productId != null) {
      var res = await controller.getProductById(productId);
      if (res == null) {
        debugPrint('Product not found');
        Get.offAll(() => const HomeScreen());
        return;
      } else {
        Get.off(() => ProductDetailScreen(
              product: controller.product,
            ));
      }
    }
  }
}
