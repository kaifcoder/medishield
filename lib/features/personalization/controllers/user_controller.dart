import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/data/repositories/user_repository.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/logging/logger.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  Rx<UserModel> user = UserModel.empty().obs;
  final userLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  RxString homeScreenmessage = ''.obs;
  final phoneNumber = TextEditingController();
  final guest = AuthenticationRepository.instance.deviceStorage.read('guest');

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
    updateHomeScreenMessage();
  }

  // fetch user data from repository
  Future fetchUserRecord() async {
    try {
      userLoading(true);
      final user = await userRepository.getUserData();
      this.user(user);
      userLoading(false);
    } catch (e) {
      TLoggerHelper.error(e.toString());
    } finally {
      userLoading(false);
    }
  }

  //get current time and update home screen message
  void updateHomeScreenMessage() {
    final currentTime = DateTime.now().hour;
    if (currentTime < 12) {
      homeScreenmessage('Good Morning');
    } else if (currentTime < 17) {
      homeScreenmessage('Good Afternoon');
    } else {
      homeScreenmessage('Good Evening');
    }
  }

  // update user data in repository
  Future updateUserRecord(
    String firstName,
    String lastName,
  ) async {
    try {
      final user = await userRepository.updateUserData(
        firstName,
        lastName,
      );
      THelperFunctions.showSnackBar('Profile updated successfully');
      this.user(user);
    } catch (e) {
      TLoggerHelper.error(e.toString());
    }
  }

  // update phone number in repository
  Future updatePhoneRecord(
    String phone,
  ) async {
    try {
      final user = await userRepository.updatePhoneData(
        phone,
      );
      THelperFunctions.showSnackBar('Phone number updated successfully');
      this.user(user);
    } catch (e) {
      TLoggerHelper.error(e.toString());
    }
  }
}
