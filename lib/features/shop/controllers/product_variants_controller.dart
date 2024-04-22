import 'package:get/get.dart';

class ProductVariantsController extends GetxController {
  static ProductVariantsController get instance => Get.find();
  RxString selectVariantId = ''.obs;
  RxInt selectedVariantIndex = 0.obs;

  void selectVariant(String id, int index) {
    selectVariantId.value = id;
    selectedVariantIndex.value = index;
  }
}
