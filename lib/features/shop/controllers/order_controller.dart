import 'package:get/get.dart';
import 'package:medishield/data/repositories/order_repository.dart';
import 'package:medishield/features/shop/models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final orderRepo = Get.put(OrderRepository());

  final orderData = <OrderModel>[].obs;

  final amount = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchOrders();
  }

  // create order to server

  createOrder(String paymentId, int amount, int shipping) async {
    try {
      final res = await orderRepo.createOrder(
        paymentId,
        amount,
        shipping,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch orders from repository

  fetchOrders() async {
    try {
      final res = await orderRepo.fetchOrders();
      orderData.value = List<OrderModel>.from(
        res['data'].map((x) => OrderModel.fromJson(x)),
      );
    } catch (e) {
      rethrow;
    }
  }
}
