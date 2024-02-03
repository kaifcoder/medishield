import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/features/shop/models/cart_model.dart';

class OrderModel {
  final String id;
  final String orderStatus;
  final UserModel orderby;
  final List<Products> products;
  final PaymentIntent paymentIntent;
  final String createdAt;

  OrderModel({
    required this.id,
    required this.orderStatus,
    required this.orderby,
    required this.products,
    required this.paymentIntent,
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
      paymentIntent: PaymentIntent.fromJson(json['paymentIntent']),
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderStatus': orderStatus,
      'orderby': orderby.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
      'paymentIntent': paymentIntent.toJson(),
    };
  }
}

class PaymentIntent {
  final String id;
  final int amount;
  final int created;
  final String currency;
  final int shipping;

  PaymentIntent({
    required this.id,
    required this.amount,
    required this.created,
    required this.currency,
    required this.shipping,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      id: json['id'] ?? '',
      amount: json['amount'] ?? 0,
      created: json['created'] ?? 0,
      currency: json['currency'] ?? '',
      shipping: json['shipping'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'created': created,
      'currency': currency,
    };
  }
}
