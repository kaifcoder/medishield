import 'package:get/get.dart';
import 'package:medishield/data/repositories/brand_repository.dart';
import 'package:medishield/features/shop/models/brand_model.dart';
import 'package:medishield/utils/logging/logger.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  final brandRepository = Get.put(BrandRepository());

  RxList<BrandModel> brandList = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrand = <BrandModel>[].obs;
  final brandLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBrandData();
  }

  // load category from repository
  Future<void> loadBrandData() async {
    try {
      // show loader
      brandLoading(true);
      //call api
      final res = await brandRepository.getBranddata();
      // convert to list of brand model
      final brandList = res['data']
          .map<BrandModel>((brand) => BrandModel.fromJson(brand))
          .toList();
      // update brand list
      this.brandList(brandList);
      // filter featured brand
      final featuredBrand =
          brandList.where((brand) => brand.featured == true).toList();
      this.featuredBrand(featuredBrand);
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      // hide loader
      brandLoading(false);
    }
  }
}
