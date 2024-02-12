import 'package:get/get.dart';
import 'package:medishield/common/widgets/custom_snackbar.dart';
import 'package:medishield/data/repositories/authentication_repository.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/utils/constants/image_strings.dart';
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

      // save this user to database
      final newUser = UserModel(
        email: userCredential.user!.email!,
        firstName:
            userCredential.user!.displayName!.toString().split(' ').first,
        lastName: userCredential.user!.displayName!.toString().split(' ').last,
        mobile: '',
        password: '',
        isEmailVerified: userCredential.user!.emailVerified,
        googleAuthToken: userCredential.user!.uid,
      );

      if (await isUserExist(newUser.googleAuthToken)) {
        await AuthenticationRepository.instance.loginWithGoogle();
      } else {
        await AuthenticationRepository.instance.signup(newUser);
        await AuthenticationRepository.instance.deviceStorage
            .write('isVerfied', true);
      }

      FullScreenLoader.stopLoading();
      await AuthenticationRepository.instance.screenRedirect();
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
