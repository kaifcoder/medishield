import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';
import 'package:medishield/utils/logging/logger.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  // fetch categories from server
  getCategorydata() async {
    try {
      final res = await THttpHelper.get('api/category/');
      return res;
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    }
  }
}
