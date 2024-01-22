import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medishield/features/authentication/models/user.dart';
import 'package:medishield/utils/helpers/helper_functions.dart';
import 'package:medishield/utils/http/http_client.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  // signup and call network api
  Future signup(User data) async {
    final res = await THttpHelper.post('api/user/register', data.toJson());
    return res;
  }

  // login and call network api
}
