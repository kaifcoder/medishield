import 'package:get/get.dart';
import 'package:medishield/utils/http/http_client.dart';
import 'package:medishield/utils/logging/logger.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // fetch banners from server

  fetchBannerdata() async {
    try {
      final res = await THttpHelper.get('api/product/banner/getBannerProduct');
      return res;
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    }
  }
}
