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
  fetchProductById(String id) async {
    try {
      final res = await THttpHelper.get('api/product/$id');
      print(res.toString());
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // fetch products by search from server
  fetchProductsBySearch(int page, int limit, String search) async {
    try {
      final res = await THttpHelper.get(
          'api/product?page=$page&limit=$limit&search=$search');
      return res;
    } catch (e) {
      rethrow;
    }
  }
  // fetch products by semantically similar from server

  fetchProdctsforContext(String context) async {
    try {
      final res = await THttpHelper.get(
          'api/product/context/contextualSearch?search=$context');
      return res['data'].toString();
    } catch (e) {
      rethrow;
    }
  }

  // fetch products by sort from server
}
