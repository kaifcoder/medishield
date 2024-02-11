import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:medishield/features/authentication/controllers/signup/verify_email_controller.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();

    deviceStorage.writeIfNull('token', null);
    deviceStorage.writeIfNull('email', null);
    deviceStorage.writeIfNull('guest', null);
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    final token = await deviceStorage.read('token');
    final guest = await deviceStorage.read('guest');

    if (guest != null && guest == true) {
      return Get.offAll(() => const NavigationMenu());
    } else if (token != null) {
      final isVerfied = await deviceStorage.read('isVerfied');
      if (isVerfied != null && isVerfied == true) {
        return Get.offAll(() => const NavigationMenu());
      }
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

  // skip login
  Future skipLogin() async {
    UserModel(
      firstName: 'Guest',
      lastName: 'User',
      email: '',
      password: '',
    );
    await deviceStorage.writeIfNull('token', null);
    await deviceStorage.writeIfNull('email', null);
    await deviceStorage.writeIfNull('isVerfied', null);
    await deviceStorage.write('guest', true);
    Get.offAll(() => const NavigationMenu());
  }

  // signup user
  Future signup(UserModel data) async {
    try {
      final res = await THttpHelper.post('api/user/register', data.toJson());
      await deviceStorage.writeIfNull('token', res['token']);
      await deviceStorage.writeIfNull('email', res['email']);
      deviceStorage.remove('guest');
      return res;
    } on Exception catch (e) {
      await deviceStorage.remove('token');
      await deviceStorage.write('token', null);
      await deviceStorage.remove('email');
      await deviceStorage.write('email', null);
      await deviceStorage.remove('isVerfied');
      await deviceStorage.write('isVerfied', null);
      await deviceStorage.remove('guest');
      await deviceStorage.write('guest', false);
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      THelperFunctions.showSnackBar(
          'Oh Snap! $e'.replaceAll('Exception: ', ''));
    }
  }

  // verify email / resend email
  Future<void> sendVerfiyEmail() async {
    final token = await deviceStorage.read('token');

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
      deviceStorage.remove('guest');
      return res;
    } on Exception catch (e) {
      await deviceStorage.remove('token');
      await deviceStorage.write('token', null);
      await deviceStorage.remove('email');
      await deviceStorage.write('email', null);
      await deviceStorage.remove('isVerfied');
      await deviceStorage.write('isVerfied', null);
      await deviceStorage.remove('guest');
      await deviceStorage.write('guest', false);
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      THelperFunctions.showSnackBar('Oh Snap! $e');
    }
  }

  // forgot password
  Future forgetPassword(String email) async {
    try {
      final res = await THttpHelper.post('api/user/forgot-password-token', {
        'email': email,
      });
      return res;
    } on Exception {
      rethrow;
    }
  }

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
      deviceStorage.remove('guest');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  loginWithGoogle() async {
    try {
      final res = await THttpHelper.get(
          'api/user/loginWithGoogle/${FirebaseAuth.instance.currentUser!.uid}');
      await deviceStorage.write('token', res['token']);

      await deviceStorage.write(
          'email', FirebaseAuth.instance.currentUser!.email);

      await deviceStorage.write('isVerfied', true);
      await deviceStorage.remove('guest');
    } catch (e) {
      rethrow;
    }
  }

  // sign in with phone
  Future signInWithPhone(String phone) async {
    try {
      final res = await THttpHelper.post('api/user/loginWithPhone', {
        'mobile': phone,
      });
      return res;
    } on Exception {
      rethrow;
    }
  }

  // logout user
  logout() async {
    await deviceStorage.remove('token');
    await deviceStorage.write('token', null);
    await deviceStorage.remove('email');
    await deviceStorage.write('email', null);
    await deviceStorage.remove('isVerfied');
    await deviceStorage.write('isVerfied', null);
    await deviceStorage.remove('guest');
    await deviceStorage.write('guest', false);
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    await deviceStorage.erase();
    // reset all controllers
    Get.offAll(() => const LoginScreen());
  }
}
