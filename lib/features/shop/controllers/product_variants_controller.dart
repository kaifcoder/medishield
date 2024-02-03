import 'package:get/get.dart';

class ProductVariantsController extends GetxController {
  static ProductVariantsController get instance => Get.find();
  RxInt selectVariantId = 0.obs;
  RxInt selectedVariantIndex = 0.obs;

  void selectVariant(int id, int index) {
    selectVariantId.value = id;
    selectedVariantIndex.value = index;
  }
}
