import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';

class SearchControler extends GetxController {
  static SearchControler get instance => Get.find();
  final productcontroller = ProductController.instance;
  final searchQuery = ''.obs;
  final searchHistory = <String>[].obs;
  TextEditingController searchText = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchFocusNode.requestFocus();
    searchQuery.value = '';
  }

  @override
  void onClose() {
    searchText.dispose();
    productcontroller.SearchProducts.clear();
    searchFocusNode.dispose();
    super.onClose();
  }

  Future<void> searchProducts() async {
    // add a delay while searching
    await productcontroller.fetchProductsbySearch(searchQuery.value);
  }

  void addToSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
    }
  }

  void removeFromSearchHistory(String query) {
    searchHistory.remove(query);
  }

  void clearSearchHistory() {
    searchHistory.clear();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void clearSearchQuery() {
    searchQuery.value = '';
  }
}
