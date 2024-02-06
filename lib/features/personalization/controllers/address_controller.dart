import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/data/repositories/address_repository.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/personalization/models/address_model.dart';
import 'package:medishield/utils/helpers/network_manager.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final addressRepository = Get.put(AddressRepository());
  final addresses = <AddressModel>[].obs;
  final selectedAddress = AddressModel().obs;
  GlobalKey<FormState> addressFormKey =
      GlobalKey<FormState>(debugLabel: 'addressFormKey');

  // future builder refresh key
  RxBool refreshData = true.obs;
  final name = TextEditingController();
  final addresstext = TextEditingController();
  final mobile = TextEditingController();
  final pincode = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final country = TextEditingController(
    text: 'India',
  );

  final guest = AuthenticationRepository.instance.deviceStorage.read('guest');

  @override
  void onInit() {
    if (AuthenticationRepository.instance.deviceStorage.read('token') == null) {
      return;
    }
    fetchAddresses();
    super.onInit();
  }

  // get list of addresses from the repository
  Future<void> fetchAddresses() async {
    if (guest != null && guest == true) {
      return;
    }
    try {
      addresses.value = await addressRepository.fetchAddresses();
      selectedAddress.value =
          addresses.isNotEmpty ? addresses.first : AddressModel();
    } catch (e) {
      CustomSnackbar.errorSnackBar(e.toString());
    }
  }

  // add new address to the list
  Future<void> addAddress() async {
    try {
      // check internet
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        return CustomSnackbar.errorSnackBar('No internet connection');
      }

      // //form validation
      if (!addressFormKey.currentState!.validate()) {
        // FullScreenLoader.stopLoading();
        return;
      }
      final data = AddressModel(
        name: name.text.trim(),
        address: addresstext.text.trim(),
        mobile: mobile.text.trim(),
        pincode: pincode.text.trim(),
        state: state.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
      );
      // call add address api
      await addressRepository.addAddress(data);
      // update the list of addresses
      refreshData.toggle();
      // select the newly added address
      selectedAddress.value = data;
      // reset the form
      addressFormKey.currentState!.reset();
      Get.back();
    } catch (e) {
      CustomSnackbar.errorSnackBar(e.toString());
    }
  }

  // delete address from the list
  Future<void> deleteAddress(String id) async {
    try {
      await addressRepository.deleteAddress(id);
      refreshData.toggle();
    } catch (e) {
      CustomSnackbar.errorSnackBar(e.toString());
    }
  }
}
