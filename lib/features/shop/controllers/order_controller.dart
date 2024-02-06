import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/data/repositories/order_repository.dart';
import 'package:medishield/features/personalization/models/address_model.dart';
import 'package:medishield/features/shop/models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final orderRepo = Get.put(OrderRepository());

  final orderData = <OrderModel>[].obs;

  final amount = 0.obs;

  @override
  void onInit() async {
    if (AuthenticationRepository.instance.deviceStorage.read('token') == null) {
      return;
    }
    super.onInit();
    await fetchOrders();
  }

  // dispose order data
  @override
  void onClose() {
    orderData.clear();
    super.onClose();
  }

  // create order to server

  createOrder(String paymentId, int amount, int shipping,
      AddressModel shippingAddress) async {
    try {
      if (AuthenticationRepository.instance.deviceStorage.read('token') ==
          null) {
        return CustomSnackbar.errorSnackBar('Please login to place order');
      }
      final res = await orderRepo.createOrder(
        paymentId,
        amount,
        shipping,
        shippingAddress,
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch orders from repository

  fetchOrders() async {
    try {
      if (AuthenticationRepository.instance.deviceStorage.read('token') ==
          null) {
        return;
      }
      final res = await orderRepo.fetchOrders();
      orderData.value = List<OrderModel>.from(
        res['data'].map((x) => OrderModel.fromJson(x)),
      );
    } catch (e) {
      rethrow;
    }
  }
}
