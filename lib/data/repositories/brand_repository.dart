import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';
import 'package:medishield/utils/logging/logger.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();
  // fetch brands from server
  getBranddata() async {
    try {
      final res = await THttpHelper.get('api/brand/');
      return res;
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    }
  }
}
