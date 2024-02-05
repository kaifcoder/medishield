import 'package:get/get.dart';
import 'package:medishield/features/personalization/models/address_model.dart';
import 'package:medishield/utils/http/http_client.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  // create order to server
  createOrder(String paymentId, int amount, int shipping,
      AddressModel shippingAddress) async {
    try {
      final res = THttpHelper.post('api/user/cart/create-order', {
        'paymentId': paymentId,
        'amount': amount,
        'shipping': shipping,
        'shippingAddress': shippingAddress,
      });
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch orders from server
  fetchOrders() async {
    try {
      final res = THttpHelper.get('api/user/get-orders');
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
