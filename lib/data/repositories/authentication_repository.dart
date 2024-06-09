import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/features/authentication/screens/login/login.dart';
import 'package:medishield/features/authentication/screens/phone_auth/phone_auth.dart';
import 'package:medishield/features/authentication/screens/signup/verify_email.dart';
import 'package:medishield/navigation_menu.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:medishield/utils/exceptions/firebase_exceptions.dart';
import 'package:medishield/utils/exceptions/platform_exceptions.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/http/http_client.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;

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
      rethrow;
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
      debugPrint(TPlatformException(e.code).message);
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

  loginWithPhone() async {
    try {
      final res = await THttpHelper.get(
          'api/user/loginWithGoogle/${FirebaseAuth.instance.currentUser!.uid}');
      await deviceStorage.write('token', res['token']);
      await deviceStorage.write('email', res['email']);
      await deviceStorage.write('isVerfied', true);
      await deviceStorage.remove('guest');
      debugPrint('loginwithphone RES: $res');
    } catch (e) {
      rethrow;
    }
  }

// sign in with apple
  Future signInWithApple() async {
    try {
      AppleAuthProvider appleProvider = AppleAuthProvider();
      appleProvider = appleProvider.addScope('email');
      appleProvider = appleProvider.addScope('name');
      final credential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      debugPrint(credential.toString());

      // check if user exist or not in database if exist then login else register
      final res = await THttpHelper.get(
          'api/user/loginWithGoogle/${credential.user!.uid}');
      if (res['status']) {
        await deviceStorage.write('token', res['token']);
        await deviceStorage.write('email', credential.user!.email);
        await deviceStorage.write('isVerfied', true);
        await deviceStorage.remove('guest');
        screenRedirect();
      } else {
        final code = TextEditingController();
        Get.bottomSheet(
          SingleChildScrollView(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(children: [
              const TSectionHeading(title: 'Provide Referral Code (Optional)'),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                controller: code,
                decoration: const InputDecoration(hintText: 'Referral Code'),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              ElevatedButton(
                onPressed: () async {
                  final newUser = UserModel(
                    email: credential.user!.email!,
                    firstName: credential.user!.displayName!
                        .toString()
                        .split(' ')
                        .first,
                    lastName: credential.user!.displayName!
                                .toString()
                                .split(' ')
                                .last ==
                            credential.user!.displayName!
                                .toString()
                                .split(' ')
                                .first
                        ? ' '
                        : credential.user!.displayName!
                            .toString()
                            .split(' ')
                            .last,
                    password: '',
                    googleAuthToken: credential.user!.uid,
                    referralCode: code.text.trim(),
                  );
                  final res = await signup(newUser);
                  await deviceStorage.write('token', res['token']);
                  await deviceStorage.write('email', res['email']);
                  await deviceStorage.write('isVerfied', true);
                  await deviceStorage.remove('guest');
                  screenRedirect();
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text("Register"),
                  ),
                ),
              ),
            ]),
          ),
          backgroundColor: Colors.white,
          isScrollControlled: true,
          isDismissible: false,
        );
      }
    } catch (e) {
      debugPrint('error $e');
      rethrow;
    }
  }

  // sign in with phone
  Future signInWithPhone(String phone) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          final credentials = await _auth.signInWithCredential(credential);
          final userExist = await THttpHelper.get(
              'api/user/isUserExist/${credentials.user!.uid}');
          if (credentials.user != null) {
            // add user to database
            if (credentials.additionalUserInfo!.isNewUser ||
                !userExist['status']) {
              final name = TextEditingController();
              final email = TextEditingController();
              final referralCode = TextEditingController();
              Get.bottomSheet(
                SingleChildScrollView(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(children: [
                    const TSectionHeading(title: 'Enter your Name and Email'),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: name,
                      decoration:
                          const InputDecoration(hintText: 'Name (required)'),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: email,
                      decoration:
                          const InputDecoration(hintText: 'Email (optional)'),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: referralCode,
                      decoration: const InputDecoration(
                          hintText: 'Referral Code (optional)'),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var emailfinal = "";
                        if (email.text.isEmpty) {
                          emailfinal =
                              '${credentials.user!.phoneNumber!.substring(3)}@${name.text.split(' ').first}.com';
                        } else {
                          emailfinal = email.text.trim();
                        }
                        final data = UserModel(
                          firstName: name.text.split(' ').first,
                          lastName: name.text.split(' ').first ==
                                  name.text.split(' ').last
                              ? ' '
                              : name.text.split(' ').last,
                          email: emailfinal,
                          password: '',
                          mobile: credentials.user!.phoneNumber!,
                          googleAuthToken: credentials.user!.uid,
                          referralCode: referralCode.text.trim(),
                        );
                        final res = await THttpHelper.post(
                          'api/user/register',
                          data.toJson(),
                        );
                        debugPrint('res $res');
                        await deviceStorage.write('token', res['token']);
                        await deviceStorage.write('email', res['email']);
                        await deviceStorage.write('isVerfied', true);
                        await deviceStorage.remove('guest');
                        screenRedirect();
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text("Register"),
                        ),
                      ),
                    ),
                  ]),
                ),
                backgroundColor: Colors.white,
                isScrollControlled: true,
                isDismissible: false,
              );
            } else {
              await loginWithPhone();
              screenRedirect();
            }
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
          Get.to(
            () => OTPScreen(
              phoneNumber: phone.trim(),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          debugPrint(e.message);
          CustomSnackbar.errorSnackBar('Something went wrong please try again');
        },
      );
    } on Exception {
      rethrow;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      final credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp),
      );
      debugPrint('credentials $credentials');
      final userExist = await THttpHelper.get(
          'api/user/isUserExist/${credentials.user!.uid}');
      debugPrint('verification id ${verificationId.value}');
      debugPrint('credentials ${credentials.user!.uid}');
      debugPrint('otp $otp');
      debugPrint('userExist $userExist');

      if (credentials.user != null) {
        // add user to database
        if (credentials.additionalUserInfo!.isNewUser || !userExist['status']) {
          final name = TextEditingController();
          final email = TextEditingController();
          final referralCode = TextEditingController();
          Get.bottomSheet(
            SingleChildScrollView(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(children: [
                const TSectionHeading(title: 'Enter your Name and Email'),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: name,
                  decoration:
                      const InputDecoration(hintText: 'Name (required)'),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: email,
                  decoration:
                      const InputDecoration(hintText: 'Email (optional)'),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: referralCode,
                  decoration: const InputDecoration(
                      hintText: 'Referral Code (optional)'),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var emailfinal = "";
                    if (email.text.isEmpty) {
                      emailfinal =
                          '${credentials.user!.phoneNumber!.substring(3)}@${name.text.split(' ').first}.com';
                    } else {
                      emailfinal = email.text.trim();
                    }
                    final data = UserModel(
                      firstName: name.text.split(' ').first,
                      lastName: name.text.split(' ').first ==
                              name.text.split(' ').last
                          ? ' '
                          : name.text.split(' ').last,
                      email: emailfinal,
                      password: '',
                      mobile: credentials.user!.phoneNumber!,
                      googleAuthToken: credentials.user!.uid,
                      referralCode: referralCode.text.trim(),
                    );
                    final res = await THttpHelper.post(
                      'api/user/register',
                      data.toJson(),
                    );
                    debugPrint('res $res');
                    await deviceStorage.write('token', res['token']);
                    await deviceStorage.write('email', res['email']);
                    await deviceStorage.write('isVerfied', true);
                    await deviceStorage.remove('guest');
                    screenRedirect();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text("Register"),
                    ),
                  ),
                ),
              ]),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            isDismissible: false,
          );
        } else {
          await loginWithPhone();
          screenRedirect();
        }
      }
      return credentials.user != null ? true : false;
    } catch (e) {
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
