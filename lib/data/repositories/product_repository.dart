import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';

class ProductRepository extends GetxController {
  // fetch products by category or brand from server

  fetchProducts(int page, int limit, String category) async {
    try {
      final res = await THttpHelper.get(
          'api/product?page=$page&limit=$limit&category=$category');
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch products by price from server
  fetchProductById(int id) async {
    try {
      final res = await THttpHelper.get('api/product/$id');
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch products by rating from server

  // fetch products by search from server

  // fetch products by filter from server

  // fetch products by sort from server
}
