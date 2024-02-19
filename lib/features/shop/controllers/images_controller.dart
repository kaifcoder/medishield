import 'package:get/get.dart';
import 'package:medishield/features/shop/models/product_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();
  RxString selectedImage = ''.obs;

  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};
    images.add((product.thumbnailUrl.contains('http'))
        ? product.thumbnailUrl
        : 'https://images.dentalkart.com/media/catalog/product/${product.thumbnailUrl}');
    selectedImage.value = (product.thumbnailUrl.contains('http'))
        ? product.thumbnailUrl
        : 'https://images.dentalkart.com/media/catalog/product/${product.thumbnailUrl}';
    for (var element in product.mediaGalleryEntries) {
      images.add((element.file.contains('http'))
          ? element.file
          : 'https://images.dentalkart.com/media/catalog/product/${element.file}');
    }
    if (product.childProducts.length > 1) {
      for (var element in product.childProducts) {
        for (var media in element.mediaGalleryEntries) {
          images.add(
              'https://images.dentalkart.com/media/catalog/product/${media.file}');
        }
      }
    }

    return images.toList();
  }

  void showEnlargeImage(String image) {
    selectedImage.value = image;
  }
}
