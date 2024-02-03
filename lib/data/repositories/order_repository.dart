import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  // create order to server
  createOrder(String paymentId, int amount, int shipping) async {
    try {
      final res = THttpHelper.post('api/user/cart/create-order',
          {'paymentId': paymentId, 'amount': amount, 'shipping': shipping});
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch orders from server
  fetchOrders() async {
    print('fetchOrders');

    try {
      final res = THttpHelper.get('api/user/get-orders');
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch order by id from server
  fetchOrderById() async {
    print('fetchOrderById');
    try {
      final res = THttpHelper.get('/user/fetchOrderById');
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
