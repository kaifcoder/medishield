import 'package:get/get.dart';
import 'package:medishield/data/repositories/category_repository.dart';
import 'package:medishield/features/shop/models/category_model.dart';
import 'package:medishield/utils/logging/logger.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final categoryRepository = Get.put(CategoryRepository());

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategory = <CategoryModel>[].obs;
  final categoryLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategorydata();
  }

  // load category from repository
  Future<void> loadCategorydata() async {
    try {
      // show loader
      categoryLoading(true);
      //call api
      final res = await categoryRepository.getCategorydata();
      // convert to list of category model
      final categoryList = res['categories']
          .map<CategoryModel>((category) => CategoryModel.fromJson(category))
          .toList();
      // update category list
      this.categoryList(categoryList);
      // filter featured category
      final featuredCategory =
          categoryList.where((category) => category.featured == true).toList();
      // update featured category list bring the Offer category to the front

      this.featuredCategory(featuredCategory);
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      // hide loader
      categoryLoading(false);
    }
  }
}
