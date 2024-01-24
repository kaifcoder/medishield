import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // fetch user data from repository
  Future fetchUserRecord() async {
    try {
      userLoading(true);
      final user = await userRepository.getUserData();
      this.user(user);
      userLoading(false);
    } catch (e) {
      user(UserModel.empty());
      TLoggerHelper.error(e.toString());
    } finally {
      userLoading(false);
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
}
