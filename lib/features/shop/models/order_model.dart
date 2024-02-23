import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/features/personalization/models/address_model.dart';
import 'package:medishield/features/shop/models/cart_model.dart';

class OrderModel {
  final String id;
  final String orderStatus;
  final UserModel orderby;
  final String? trackingNumber;
  final List<Products> products;
  final PaymentIntent paymentIntent;
  final AddressModel shippingAddress;
  final String createdAt;

  OrderModel({
    required this.id,
    required this.orderStatus,
    required this.orderby,
    required this.products,
    required this.paymentIntent,
    this.trackingNumber,
    required this.shippingAddress,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['_id'] ?? '',
        orderStatus: json['orderStatus'] ?? '',
        orderby: UserModel.fromJson(json['orderby']),
        products: json['products'].map<Products>((product) {
          return Products.fromJson(product);
        }).toList(),
        trackingNumber: json['trackingNumber'] ?? '',
        paymentIntent: PaymentIntent.fromJson(json['paymentIntent']),
        createdAt: json['createdAt'] ?? '',
        shippingAddress: AddressModel.fromJson(json['shippingAddress']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderStatus': orderStatus,
      'orderby': orderby.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
      'paymentIntent': paymentIntent.toJson(),
      'shippingAddress': shippingAddress.toJson(),
    };
  }
}

class PaymentIntent {
  final String id;
  final int amount;
  final int created;
  final String currency;
  final int shipping;
  final int msc;

  PaymentIntent({
    required this.id,
    required this.amount,
    required this.created,
    required this.currency,
    required this.msc,
    required this.shipping,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      id: json['id'] ?? '',
      amount: json['amount'] ?? 0,
      created: json['created'] ?? 0,
      currency: json['currency'] ?? '',
      shipping: json['shipping'] ?? 0,
      msc: json['msc'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'created': created,
      'currency': currency,
      'shipping': shipping,
      'msc': msc,
    };
  }
}
