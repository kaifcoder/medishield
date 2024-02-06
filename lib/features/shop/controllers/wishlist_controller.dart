import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/data/repositories/wishlist_repository.dart';
import 'package:medishield/features/shop/models/product_model.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();
  final wishlistrepo = Get.put(WishlistRepository());
  final auth = AuthenticationRepository.instance;
  final isLoading = false.obs;

  RxList<ProductModel> wishlist = <ProductModel>[].obs;

  @override
  void onInit() {
    if (auth.deviceStorage.read('guest') == true ||
        auth.deviceStorage.read('token') == null) {
      return;
    }
    fetchItems();
    super.onInit();
  }

  @override
  void onClose() {
    wishlist.clear();
    super.onClose();
  }

  fetchItems() async {
    try {
      if (auth.deviceStorage.read('guest') == true ||
          auth.deviceStorage.read('token') == null) {
        return;
      }
      final res = await wishlistrepo.fetchItems();
      wishlist.assignAll(res['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  toggleWishlist(String prodId) async {
    try {
      if (auth.deviceStorage.read('guest') == true) {
        return CustomSnackbar.errorSnackBar('Please login to add to wishlist');
      }
      await wishlistrepo.addorremToWishlist(prodId);
      fetchItems();
    } catch (e) {
      rethrow;
    }
  }

  isWishlisted(String prodId) {
    return wishlist.any((element) => element.prodId == prodId);
  }
}
