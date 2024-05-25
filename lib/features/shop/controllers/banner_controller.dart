import 'package:get/get.dart';
import 'package:medishield/data/repositories/banner_repository.dart';
import 'package:medishield/features/shop/models/banner_model.dart';
import 'package:medishield/utils/logging/logger.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find<BannerController>();
  final carouselIndex = 0.obs;
  final isLoading = false.obs;
  final totalBanners = 9.obs;
  RxList<BannerModel> bannerList = <BannerModel>[].obs;

  @override
  void onInit() {
    getBannerdata();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carouselIndex.value = index;
  }

  // fetch banners from server
  getBannerdata() async {
    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannerRepository());
      final res = await bannerRepo.fetchBannerdata();
      bannerList.assignAll(
        (res['data'] as List<dynamic>)
            .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      totalBanners.value = bannerList.length;
      isLoading.value = false;
      update();
    }
  }
}
