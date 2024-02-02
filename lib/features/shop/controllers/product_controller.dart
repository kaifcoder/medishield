import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/data/repositories/product_repository.dart';
import 'package:medishield/features/shop/models/banner_model.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/logging/logger.dart';

class ProductController extends GetxController {
  final productRepo = Get.put(ProductRepository());
  static ProductController get instance => Get.find();
  final isLoading = false.obs;

  RxList<ProductModel> Endodontics = <ProductModel>[].obs;
  RxList<ProductModel> Orthodontics = <ProductModel>[].obs;
  RxList<ProductModel> Instruments = <ProductModel>[].obs;
  RxList<ProductModel> CategoryProducts = <ProductModel>[].obs;
  RxList<BannerModel> SearchProducts = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchEndoProduct();
    fetchorthoProduct();
    fetchInstruProduct();
    super.onInit();
  }

  void fetchEndoProduct() async {
    try {
      isLoading.value = true;

      // fetch
      final response = await productRepo.fetchProducts(
        10,
        4,
        'Endodontics',
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

  void fetchorthoProduct() async {
    try {
      isLoading.value = true;

      // fetch
      final response = await productRepo.fetchProducts(
        16,
        4,
        'Orthodontics',
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

  void fetchInstruProduct() async {
    try {
      isLoading.value = true;

      // fetch
      final response = await productRepo.fetchProducts(
        16,
        4,
        'Instruments',
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

  fetchProductsbycategory(
    String category,
  ) async {
    try {
      isLoading.value = true;

      final response = await productRepo.fetchProducts(
        1,
        16,
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

  getProductById(int id) async {
    try {
      isLoading.value = true;
      // fetch
      final response = await productRepo.fetchProductById(id);
      // assign to list
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

  getProductPrices(ProductModel product) {
    if (product.childProducts.isEmpty) {
      return product.price.minimalPrice.toString();
    }
    if (product.childProducts.length == 1) {
      return product.childProducts.first.price.minimalPrice.toString();
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
}
