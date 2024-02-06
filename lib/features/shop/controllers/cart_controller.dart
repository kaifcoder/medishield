import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/data/repositories/cart_repository.dart';
import 'package:medishield/features/shop/models/cart_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  final cartRepo = Get.put(CartRepository());
  final auth = AuthenticationRepository.instance;
  final userCart = CartModel(
    id: '',
    products: [],
    cartTotal: 0,
    orderby: '',
  ).obs;
  var total = 0.obs;
  var grandTotal = 0.obs;

  @override
  void onInit() async {
    if (auth.deviceStorage.read('guest') == true ||
        auth.deviceStorage.read('token') == null) {
      return;
    }
    super.onInit();
    await fetchCartItems();
  }

  fetchCartItems() async {
    try {
      if (auth.deviceStorage.read('guest') == true ||
          auth.deviceStorage.read('token') == null) {
        return;
      }
      final res = await cartRepo.fetchCartItems();
      if (res['data'] == null) {
        userCart.value = CartModel(
          id: '',
          products: [],
          cartTotal: 0,
          orderby: '',
        );
        return;
      }
      userCart.value = CartModel.fromJson(res['data']);
      total.value = userCart.value.cartTotal;
      grandTotal.value = userCart.value.cartTotal + 150;
    } catch (e) {
      rethrow;
    }
  }

  void addToCart(
      {required String product,
      required int count,
      required int price,
      String v = ''}) async {
    try {
      if (auth.deviceStorage.read('token') == null) {
        CustomSnackbar.errorSnackBar('Please login to purchase products');
        return;
      }
      await cartRepo.addtocart(
        prodId: product,
        count: count,
        price: price,
        v: v,
      );
      CustomSnackbar.successSnackBar('Added to cart');
      await fetchCartItems();
    } catch (e) {
      rethrow;
    }
  }

  void removeFromCart(
      {required String product,
      required int count,
      required int price,
      String v = ''}) async {
    try {
      if (count == -1) {
        await cartRepo.removeFromCart(
          prodId: product,
          v: v,
        );
        CustomSnackbar.successSnackBar('Removed from cart');
        await fetchCartItems();
        return;
      } else if (count == 1) {
        await cartRepo.addtocart(
          prodId: product,
          count: -count,
          price: -price,
          v: v,
        );
        CustomSnackbar.successSnackBar('Removed from cart');
        await fetchCartItems();
        return;
      }

      await fetchCartItems();
    } catch (e) {
      rethrow;
    }
  }

  void clearCart() async {
    try {
      await cartRepo.clearCart();
      await fetchCartItems();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {
    userCart.close();
    super.onClose();
  }
}
