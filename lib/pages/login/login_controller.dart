import 'package:get/get.dart';

import '../../models/user.dart';
import '../../service/api/user.dart';

class LoginController extends GetxController {
  RxString phone = "".obs;
  RxString password = "".obs;

  Future<User?> login() async {
    var result = await UserService.login(phone.value, password.value);
    if (result.isSuccess && result.data["data"] != null) {
      return User.fromMap(result.data["data"]);
    }
    return null;
  }
}
