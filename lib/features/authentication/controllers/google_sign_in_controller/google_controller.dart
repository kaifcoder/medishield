import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/common/widgets/text/t_section_heading.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/utils/constants/image_strings.dart';
import 'package:medishield/utils/constants/sizes.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/helpers/network_manager.dart';
import 'package:medishield/utils/http/http_client.dart';
import 'package:medishield/utils/popups/full_screen_loader.dart';

class GoogleController extends GetxController {
  static GoogleController get instance => Get.find();

  getUserTokenFromServer(uid) async {
    final res = await THttpHelper.get('api/user/loginWithGoogle/$uid');
    return res['token'];
  }

  isUserExist(uid) async {
    final res = await THttpHelper.get('api/user/isUserExist/$uid');
    return res['status'];
  }

  Future<void> googleSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Signing with Google...', TImages.loader);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return THelperFunctions.showSnackBar('No internet connection');
      }
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      if (await isUserExist(userCredential.user!.uid)) {
        await FullScreenLoader.stopLoading();
        await AuthenticationRepository.instance.loginWithGoogle();
      } else {
        // save this user to database
        await FullScreenLoader.stopLoading();
        final code = TextEditingController();
        await Get.bottomSheet(
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
                    email: userCredential.user!.email!,
                    firstName: userCredential.user!.displayName!
                        .toString()
                        .split(' ')
                        .first,
                    lastName: userCredential.user!.displayName!
                                .toString()
                                .split(' ')
                                .last ==
                            userCredential.user!.displayName!
                                .toString()
                                .split(' ')
                                .first
                        ? ' '
                        : userCredential.user!.displayName!
                            .toString()
                            .split(' ')
                            .last,
                    mobile: '',
                    password: '',
                    isEmailVerified: userCredential.user!.emailVerified,
                    googleAuthToken: userCredential.user!.uid,
                    referralCode: code.text.trim(),
                  );
                  await AuthenticationRepository.instance.signup(newUser);
                  await AuthenticationRepository.instance.deviceStorage
                      .write('isVerfied', true);
                  await AuthenticationRepository.instance.screenRedirect();
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text("Submit"),
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields / 2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  side: BorderSide(color: Colors.grey, width: 1.0),
                ),
                onPressed: () async {
                  final newUser = UserModel(
                    email: userCredential.user!.email!,
                    firstName: userCredential.user!.displayName!
                        .toString()
                        .split(' ')
                        .first,
                    lastName: userCredential.user!.displayName!
                        .toString()
                        .split(' ')
                        .last,
                    mobile: '',
                    password: '',
                    isEmailVerified: userCredential.user!.emailVerified,
                    googleAuthToken: userCredential.user!.uid,
                  );
                  await AuthenticationRepository.instance.signup(newUser);
                  await AuthenticationRepository.instance.deviceStorage
                      .write('isVerfied', true);
                  await AuthenticationRepository.instance.screenRedirect();
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Skip',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
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
      FullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackBar(e.toString());
      rethrow;
    }
  }

  Future<void> phoneSignIn() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Signing with Phone...', TImages.loader);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return THelperFunctions.showSnackBar('No internet connection');
      }
      await AuthenticationRepository.instance.signInWithPhone(
        '+91 1234567890',
      );
      FullScreenLoader.stopLoading();
    } catch (e) {
      FullScreenLoader.stopLoading();
      CustomSnackbar.errorSnackBar(e.toString());
      rethrow;
    }
  }
}
