import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/order_controller.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final cartController = Get.put(CartController());
  final orderController = Get.put(OrderController());
}
