import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/personalization/controllers/address_controller.dart';
import 'package:medishield/features/shop/controllers/brand_controller.dart';
import 'package:medishield/features/shop/controllers/wishlist_controller.dart';
import 'package:medishield/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());
    Get.put(BrandController());
    Get.put(WishlistController());
    Get.put(AddressController());
  }
}
