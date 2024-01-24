import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
    print(res['status']);
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
        final uid = FirebaseAuth.instance.currentUser!.uid;
        final token = await getUserTokenFromServer(uid);
        await AuthenticationRepository.instance.deviceStorage
            .write('token', token);
        await AuthenticationRepository.instance.deviceStorage
            .write('email', userCredential.user!.email);
        print(token);
      } else {
        await AuthenticationRepository.instance.signup(newUser);
      }

      FullScreenLoader.stopLoading();
      THelperFunctions.showSnackBar('Congrats! You are registered');

      print(userCredential);
      await AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      print("GOOGLE CONTROLLER$e");
    }
  }
}
