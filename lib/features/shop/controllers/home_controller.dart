import 'package:get/get.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/order_controller.dart';
import 'package:medishield/features/shop/controllers/wishlist_controller.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final cartController = Get.put(CartController());
  final orderController = Get.put(OrderController());
  final addressController = AddressController.instance;
  final wishlistController = WishlistController.instance;

  @override
  void onInit() {
    super.onInit();
    cartController.fetchCartItems();
    addressController.fetchAddresses();
    orderController.fetchOrders();
    wishlistController.fetchItems();
    addressController.fetchAddresses();
  }
}
