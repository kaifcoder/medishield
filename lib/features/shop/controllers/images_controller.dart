import 'package:get/get.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/constants/text_strings.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();
  RxString selectedImage = ''.obs;

  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};
    images.add((product.thumbnailUrl.contains('http'))
        ? product.thumbnailUrl
        : TTexts.imagebaseURL + product.thumbnailUrl);
    selectedImage.value = (product.thumbnailUrl.contains('http'))
        ? product.thumbnailUrl
        : TTexts.imagebaseURL + product.thumbnailUrl;
    for (var element in product.mediaGalleryEntries) {
      images.add((element.file.contains('http'))
          ? element.file
          : TTexts.imagebaseURL + element.file);
    }
    if (product.childProducts.length > 1) {
      for (var element in product.childProducts) {
        for (var media in element.mediaGalleryEntries) {
          images.add(TTexts.imagebaseURL + media.file);
        }
      }
    }

    return images.toList();
  }

  void showEnlargeImage(String image) {
    selectedImage.value = image;
  }
}
