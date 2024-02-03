import 'package:get/get.dart';
import 'package:medishield/data/repositories/wishlist_repository.dart';
import 'package:medishield/features/shop/models/product_model.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();
  final wishlistrepo = Get.put(WishlistRepository());
  final isLoading = false.obs;

  RxList<ProductModel> wishlist = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  fetchItems() async {
    try {
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
