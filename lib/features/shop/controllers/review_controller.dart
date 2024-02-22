import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/features/shop/models/product_model.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/http/http_client.dart';

class RatingController extends GetxController {
  static RatingController get instance => Get.find();

  var rating = 0.0.obs;
  TextEditingController reviewController = TextEditingController();

  void setRating(double value) {
    rating.value = value;
  }

  void postReview(String prodId, ProductModel product) async {
    try {
      final res = await THttpHelper.put('api/product/rating', {
        'prodId': prodId,
        'star': rating.value,
        'comment': reviewController.text,
      });
      debugPrint('res: ${res['reviews']}');
      product.ratings!.assignAll(res['reviews'] as List);
      THelperFunctions.showSnackBar('Review posted successfully. Thank you!');
    } on Exception catch (e) {
      THelperFunctions.showSnackBar('Something went wrong, please try again.');
    }
  }
}
