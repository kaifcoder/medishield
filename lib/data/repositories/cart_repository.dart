import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

// add items to cart
  addtocart(
      {required String prodId,
      required int count,
      required int price,
      String v = ''}) async {
    try {
      await THttpHelper.post('api/user/cart', {
        "product": {
          "productId": prodId,
          "count": count,
          "price": price,
          "variant": v
        }
      });
    } catch (e) {
      rethrow;
    }
  }

// remove items from cart
  removeFromCart({required String prodId, required String v}) async {
    try {
      final res = await THttpHelper.post('api/user/cart/remove', {
        "product": {"productId": prodId, "variant": v}
      });

      return res;
    } catch (e) {
      rethrow;
    }
  }

// update items in cart

// fetch items from cart
  fetchCartItems() async {
    try {
      final res = await THttpHelper.get('api/user/cart');
      return res;
    } catch (e) {
      rethrow;
    }
  }

  clearCart() async {
    try {
      await THttpHelper.delete('api/user/empty-cart');
    } catch (e) {
      rethrow;
    }
  }
}
