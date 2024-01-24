import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/authentication/screens/signup/verify_email.dart';
import 'package:medishield/navigation_menu.dart';
import 'package:medishield/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:medishield/utils/exceptions/firebase_exceptions.dart';
import 'package:medishield/utils/exceptions/platform_exceptions.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
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
    if (token != null) {
      final isVerfied = await deviceStorage.read('isVerfied');
      if (isVerfied != null && isVerfied == true) {
        return Get.offAll(() => const NavigationMenu());
      }
      print(token);
      final res = await THttpHelper.get('api/user/verify-email/$token');
      if (res['message'] != 'true') {
        final email = deviceStorage.read('email');
        Get.offAll(() => VerifyEmail(
              email: email,
            ));
      } else {
        await deviceStorage.writeIfNull('isVerfied', true);
        Get.offAll(() => const NavigationMenu());
      }
    }
  }

  // signup user
  Future signup(UserModel data) async {
    try {
      final res = await THttpHelper.post('api/user/register', data.toJson());
      await deviceStorage.write('token', res['token']);
      await deviceStorage.write('email', res['email']);
      return res;
    } on Exception catch (e) {
      THelperFunctions.showSnackBar(
          'Oh Snap! $e'.replaceAll('Exception: ', ''));
    }
  }

  // verify email / resend email
  Future<void> sendVerfiyEmail() async {
    final token = await deviceStorage.read('token');
    print(token);
    await THttpHelper.get('api/user/sendVerificationEmail/$token');
  }

  // check if email is verified
  Future<bool> isEmailVerified() async {
    final token = await deviceStorage.read('token');
    final res = await THttpHelper.get('api/user/verify-email/$token');
    return res['message'] == 'true';
  }

  // login user
  Future login(String email, String password) async {
    try {
      final res = await THttpHelper.post('api/user/login', {
        'email': email,
        'password': password,
      });
      deviceStorage.write('token', res['token']);
      deviceStorage.write('email', res['email']);
      return res;
    } on Exception catch (e) {
      THelperFunctions.showSnackBar('Oh Snap! $e');
    }
  }

  // forgot password

  // sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      return;
    }
  }

  // delete account

  // logout user
  logout() async {
    await deviceStorage.remove('token');
    await deviceStorage.writeIfNull('token', null);
    await deviceStorage.remove('email');
    await deviceStorage.writeIfNull('email', null);
    await deviceStorage.remove('isVerfied');
    await deviceStorage.writeIfNull('isVerfied', null);
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginScreen());
  }
}
