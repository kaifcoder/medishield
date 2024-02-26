import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/controllers/product_controller.dart';

class SearchControler extends GetxController {
  static SearchControler get instance => Get.find();
  final productcontroller = ProductController.instance;
  final searchQuery = ''.obs;
  final searchHistory = <String>[].obs;
  Timer? searchTimer; // Timer for search

  TextEditingController searchText = TextEditingController();
  ScrollController searchScrollController = ScrollController();
  var page = 1;
  FocusNode searchFocusNode = FocusNode();
  RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    searchFocusNode.requestFocus();
    searchQuery.value = '';
    onSearchScroll();
  }

  @override
  void onClose() {
    searchText.dispose();
    productcontroller.SearchProducts.clear();
    searchFocusNode.dispose();
    page = 1;
    super.onClose();
  }

  Future<void> searchProducts() async {
    // add a delay while searching

    await productcontroller.fetchProductsbySearch(searchQuery.value, page);
  }

  void handleSearch(String value) {
    // Cancel previous timer if any
    if (searchTimer != null) {
      searchTimer!.cancel();
    }
    // Create a new timer to wait for 2 seconds
    if (value.isEmpty) {
      productcontroller.SearchProducts.clear();
    }

    if (value.isNotEmpty) {
      searchTimer = Timer(const Duration(seconds: 1), () async {
        setSearchQuery(value.trim());
        await searchProducts();
      });
    }
  }

  // pagination
  void onSearchScroll() async {
    searchScrollController.addListener(() async {
      if (searchScrollController.position.pixels ==
          searchScrollController.position.maxScrollExtent) {
        try {
          page++; // Increment page here
          isSearching.value = true;
          searchProducts(); // Call searchProducts to load the next page
        } catch (e) {
          rethrow;
        } finally {
          isSearching.value = false;
        }
      }
    });
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
    page = 1;
    searchQuery.value = query;
  }

  void clearSearchQuery() {
    searchQuery.value = '';
  }
}
