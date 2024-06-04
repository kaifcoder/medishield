// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/data/repositories/product_repository.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/logging/logger.dart';

class ProductController extends GetxController {
  final productRepo = Get.put(ProductRepository());
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final isLoadingAnother = false.obs;
  List sortOptions = [
    'Sort by price: low to high',
    'Sort by price: high to low',
  ];

  RxList<ProductModel> Endodontics = <ProductModel>[].obs;
  RxList<ProductModel> Orthodontics = <ProductModel>[].obs;
  RxList<ProductModel> Instruments = <ProductModel>[].obs;
  RxList<ProductModel> CategoryProducts = <ProductModel>[].obs;
  RxList<ProductModel> FeaturedProducts = <ProductModel>[].obs;
  ProductModel product = ProductModel.empty();
  RxList<ProductModel> SearchProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchEndoProduct();
    fetchorthoProduct();
    fetchInstruProduct();
    fetchOtherProducts();
    super.onInit();
  }

// Endocraft products fetch
  void fetchEndoProduct() async {
    try {
      isLoading.value = true;

      // fetch
      final response = await productRepo.fetchProducts(
        1,
        4,
        'Endocraft',
      );
      // assign to list
      Endodontics.assignAll(response['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());
    } catch (e) {
      CustomSnackbar.errorSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

// Medishield Healthcare products fetch
  void fetchorthoProduct() async {
    try {
      isLoading.value = true;

      // fetch
      final response = await productRepo.fetchProducts(
        1,
        4,
        'Medishield Healthcare',
      );
      // assign to list
      Orthodontics.assignAll(response['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());
    } catch (e) {
      CustomSnackbar.errorSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // clinician's choice products
  void fetchInstruProduct() async {
    try {
      isLoading.value = true;

      // fetch
      final response = await productRepo.fetchProducts(
        1,
        4,
        "Clinician's Choice",
      );
      // assign to list
      Instruments.assignAll(response['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());
    } catch (e) {
      CustomSnackbar.errorSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void fetchOtherProducts() async {
    try {
      isLoading.value = true;
      // fetch
      final response = await productRepo.fetchFeaturedProducts();
      // assign to list
      FeaturedProducts.assignAll(response['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());
    } catch (e) {
      CustomSnackbar.errorSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  fetchProductsbycategory(String category, int page) async {
    try {
      isLoadingAnother.value = true;
      final response = await productRepo.fetchProducts(
        page,
        40,
        category,
      );
      if (page == 1) {
        CategoryProducts.clear();
      }

      CategoryProducts.addAll(response['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());
      update();
    } catch (e) {
      isLoadingAnother.value = false;
      CustomSnackbar.errorSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoadingAnother.value = false;
    }
  }

  fetchProductsbycategorySpecial(String category, int limit) async {
    try {
      isLoading.value = true;

      final response = await productRepo.fetchProducts(
        1,
        limit,
        category,
      );
      CategoryProducts.assignAll(response['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());
    } catch (e) {
      CustomSnackbar.errorSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  fetchProductsbySearch(String search, int page) async {
    try {
      isLoading.value = true;
      final response = await productRepo.fetchProductsBySearch(
        page,
        50,
        search,
      );

      if (page == 1) {
        SearchProducts.clear();
      }
      SearchProducts.addAll(response['data'].map<ProductModel>((product) {
        print(product['name'].toString());
        return ProductModel.fromJson(product);
      }).toList());
    } catch (e) {
      CustomSnackbar.warningSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  getProductById(String id) async {
    try {
      isLoading.value = true;
      // fetch
      final response = await productRepo.fetchProductById(id);

      CategoryProducts.assignAll(response['data'].map<ProductModel>((product) {
        return ProductModel.fromJson(product);
      }).toList());

      if (CategoryProducts.isEmpty) {
        CustomSnackbar.warningSnackBar(
            'Product Sold Out will be available soon');
        return;
      }

      product = CategoryProducts.first;
      debugPrint('Product Name: ${product.name}');
      CategoryProducts.clear();
      update();
      return product;
    } catch (e) {
      CustomSnackbar.errorSnackBar('Something went wrong');
      TLoggerHelper.error(e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  getProductPrices(ProductModel product) {
    if (product.childProducts.length > 1) {
      return product.childProducts.last.price.minimalPrice.toString();
    } else {
      return product.price.minimalPrice.toString();
    }
  }

  calculateSalePercentage(ProductModel product) {
    if (product.price.regularPrice == 0) {
      return 0;
    }
    final price = product.price.minimalPrice;
    final regularPrice = product.price.regularPrice;
    final salePercentage = ((regularPrice - price) / regularPrice) * 100;
    return salePercentage.round();
  }

  getProductStock(ProductModel product) {
    if (product.childProducts.isEmpty) {
      return product.isInStock;
    }
    if (product.childProducts.length == 1) {
      return product.childProducts.first.isInStock;
    }
  }

  filterProductsByPrices() {
    CategoryProducts.sort((a, b) {
      final priceA = a.price.minimalPrice;
      final priceB = b.price.minimalPrice;
      return priceA.compareTo(priceB);
    });
  }
}
