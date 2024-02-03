import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';

class OrderRepository extends GetxController {
  // create order to server
  createOrder() async {
    print('createOrder');
    try {
      final res = THttpHelper.post('/user/createOrder', {});
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch orders from server
  fetchOrders() async {
    print('fetchOrders');
    try {
      final res = THttpHelper.get('/user/fetchOrders');
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

  // update order to server
}
