import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/authentication/screens/signup/verify_email.dart';
import 'package:medishield/navigation_menu.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/helpers/network_manager.dart';
import 'package:medishield/utils/http/http_client.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    deviceStorage.writeIfNull('token', null);
    deviceStorage.writeIfNull('email', null);
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    final token = await deviceStorage.read('token');
    // check internet
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      Get.offAll(() => const LoginScreen());
      return THelperFunctions.showSnackBar(
          'No internet connection please reconnect and try again');
    }

    if (token != null) {
      // check if email is verified
      final res = await THttpHelper.get('api/user/verify-email/$token');
      // if not verified send it to verification screen
      if (res['message'] != 'true') {
        Get.offAll(() => const VerifyEmail());
      } else {
        // else send it to home screen
        Get.offAll(() => const NavigationMenu());
      }
    } else {
      // send it to login screen
      Get.offAll(() => const LoginScreen());
    }
  }

  // signup user
  Future signup(User data) async {
    final res = await THttpHelper.post('api/user/register', data.toJson());
    deviceStorage.write('token', res['token']);
    deviceStorage.write('email', res['email']);
    return res;
  }

  // verify email / resend email
  sendVerfiyEmail() async {
    final res = await THttpHelper.post('api/user/verify-email', {});

    return res;
  }

  // check if user is logged in

  // reauthenticate user

  // login user
  Future login(String email, String password) async {
    final res = await THttpHelper.post('api/user/login', {
      'email': email,
      'password': password,
    });
    deviceStorage.write('token', res['token']);
    return res;
  }

  // forgot password

  // delete account

  // logout user
  logout() {
    deviceStorage.remove('token');
    deviceStorage.writeIfNull('token', null);
  }
}
