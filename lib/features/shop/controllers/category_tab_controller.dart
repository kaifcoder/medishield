import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';

class CategoryTabController extends GetxController {
  static CategoryTabController get instance => Get.find();
  final productRepo = ProductController.instance;
  RxString category = ''.obs;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    productRepo.fetchProductsbycategorySpecial(category.value, 4);
    print('CategoryTabController onInit');
    super.onInit();
  }

  void changeCategory(String category) {
    this.category.value = category;
    print('CategoryTabController changeCategory');
    try {
      isloading.value = true;
      productRepo.fetchProductsbycategorySpecial(category, 4);
    } catch (e) {
      rethrow;
    } finally {
      isloading.value = false;
    }
  }
}
