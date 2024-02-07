import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find<AllProductController>();
  final productcontroller = ProductController.instance;
  var page = 1;
  ScrollController scrollController = ScrollController();
  RxBool loadingmore = false.obs;

  final title = ''.obs; // Use Rx to make the title reactive

  void setTitle(String newTitle) {
    title.value = newTitle; // Update the title with a new value
  }

  @override
  void onInit() async {
    super.onInit();
    loadMore();
  }

  void reset() {
    page = 1;
  }

  void loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        try {
          page++;
          loadingmore.value = true;
          debugPrint('loading more $page');
          productcontroller.fetchProductsbycategory(title.value, page);
        } catch (e) {
          rethrow;
        } finally {
          loadingmore.value = false;
        }
      }
    });
  }
}
