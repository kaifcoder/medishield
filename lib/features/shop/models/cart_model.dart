import 'package:medishield/features/shop/models/product_model.dart';

class CartModel {
  final String id;
  final String orderby;
  final int cartTotal;
  final List<Products> products;

  CartModel(
      {required this.id,
      required this.orderby,
      required this.products,
      required this.cartTotal});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'] ?? '',
      orderby: json['orderby'] ?? '',
      products: json['products'].map<Products>((product) {
        return Products.fromJson(product);
      }).toList(),
      cartTotal: json['cartTotal'] ?? 0,
    );
  }
}

class Products {
  final ProductModel product;
  final int count;
  final int price;
  final String variant;

  Products({
    required this.product,
    required this.count,
    required this.price,
    required this.variant,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      product: ProductModel.fromJson(json['product']),
      count: json['count'] ?? 0,
      price: json['price'] ?? 0,
      variant: json['variant'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.prodId,
      'count': count,
      'price': price,
    };
  }
}
