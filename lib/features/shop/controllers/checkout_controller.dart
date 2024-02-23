import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/order_controller.dart';
import 'package:medishield/features/shop/screens/orders/orders.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  final cartController = CartController.instance;
  final orderController = OrderController.instance;
  final addressController = AddressController.instance;
  late Razorpay _razorpay;

  void openCheckout({
    required int amount,
    required String name,
    required String email,
    required String contact,
  }) {
    var options = {
      'key': 'rzp_test_6Fdh3YV52lDe5j',
      'amount': amount * 100,
      'name': name,
      'prefill': {'contact': contact, 'email': email},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    Get.snackbar('Payment Success', 'Payment Id: ${response.paymentId}');
    await orderController.createOrder(
        response.paymentId!,
        cartController.grandTotal.value.toInt(),
        cartController.shippingCharges,
        addressController.selectedAddress.value,
        cartController.useMediShieldCoins.value
            ? cartController.discount.value.toInt()
            : 0);
    cartController.clearCart();
    await orderController.fetchOrders();
    Get.off(() => const OrderScreen());
    disposeRazorpay();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Payment Error', 'Message: ${response.message}',
        colorText: Colors.white, backgroundColor: Colors.red);
    disposeRazorpay();
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar('External Wallet', 'Wallet Name: ${response.walletName}');
    disposeRazorpay();
  }

  initiatePayment() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void disposeRazorpay() {
    _razorpay.clear();
  }
}
