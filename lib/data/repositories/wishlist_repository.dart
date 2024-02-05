import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';

class WishlistRepository extends GetxController {
  static WishlistRepository get instance => Get.find();

  // add items to wishlist
  fetchItems() async {
    try {
      final res = THttpHelper.get(
        'api/user/wishlist',
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  addorremToWishlist(String prodId) async {
    try {
      final res = THttpHelper.put(
        'api/product/wishlist',
        {
          "prodId": prodId,
        },
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
