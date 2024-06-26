import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/features/personalization/controllers/user_controller.dart';
import 'package:medishield/features/shop/controllers/cart_controller.dart';
import 'package:medishield/features/shop/controllers/location_controller.dart';
import 'package:medishield/features/shop/controllers/order_controller.dart';
import 'package:medishield/features/shop/screens/orders/orders.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:medishield/utils/http/http_client.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  final cartController = CartController.instance;
  final orderController = OrderController.instance;
  final user = UserController.instance.user.value;
  final ccy = LocationController.instance.currencyCode;
  final addressController = AddressController.instance;
  late Razorpay _razorpay;
  void test() {
    final payload = {
      'amount': cartController.grandTotal.value.toInt(),
      'shipping': cartController.shippingCharges,
      'msc': cartController.couponMsc.value.toInt(),
      'couponId': cartController.couponId.value,
      'coDiscount': cartController.coupondiscount.value.toInt(),
    };
    debugPrint('Payload: $payload');
  }

  void openCheckout({
    required int amount,
    required String name,
    required String email,
    required String contact,
  }) async {
    var orderid = '';
    final res = await THttpHelper.post('api/user/create-razorpay-order', {
      'amount': amount,
      'currency': 'INR',
    });
    orderid = res['id'];
    debugPrint('Order Id: $orderid');
    // String key = 'rzp_live_YnUi2bA3hKgC6p';
    // String key_test = 'rzp_test_ucfh1dyXB8LY6w';
    var options = {
      'key': 'rzp_live_YnUi2bA3hKgC6p',
      'amount': amount * 100,
      'name': name,
      'order_id': orderid,
      'prefill': {'name': user.fullName, 'contact': contact, 'email': email},
      'description': 'Payment for order',
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
      response.orderId!,
      response.signature!,
      cartController.grandTotal.value.toInt(),
      cartController.shippingCharges,
      addressController.selectedAddress.value,
      cartController.couponMsc.value.toInt(),
      cartController.couponId.value,
      cartController.coupondiscount.value.toInt(),
    );
    cartController.clearCart();
    await orderController.fetchOrders();
    Get.off(() => const OrderScreen());
    UserController.instance.fetchUserRecord();
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
