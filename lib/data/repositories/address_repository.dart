import 'package:get/get.dart';
import 'package:medishield/features/personalization/models/address_model.dart';
import 'package:medishield/utils/http/http_client.dart';
import 'package:medishield/utils/logging/logger.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  // fetch list of addresses from the server
  Future<List<AddressModel>> fetchAddresses() async {
    try {
      final res = await THttpHelper.get('api/user/address');
      final List<AddressModel> addresses = [];
      for (final address in res['data']) {
        addresses.add(AddressModel.fromJson(address));
      }
      return addresses;
    } catch (e) {
      rethrow;
    }
  }

  // add new address to the server
  Future<void> addAddress(AddressModel address) async {
    try {
      await THttpHelper.put('api/user/save-address', address.toJson());
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    }
  }

  // delete address from the server
  Future<void> deleteAddress(String id) async {
    try {
      await THttpHelper.delete('api/user/address/$id');
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    }
  }
}
