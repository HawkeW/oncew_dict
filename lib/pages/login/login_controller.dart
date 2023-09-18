import 'package:get/get.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../models/user.dart';
import '../../service/api/user.dart';

class LoginController extends GetxController {
  RxString phone = "".obs;
  RxString password = "".obs;

  Rx<ButtonState> state = ButtonState.idle.obs;

  Future<User?> login() async {
    if (state.value == ButtonState.loading) return null;
    state.value = ButtonState.loading;
    var result = await UserService.login(phone.value, password.value);
    if (result.isSuccess && result.data["data"] != null) {
      state.value = ButtonState.success;
      return User.fromMap(result.data["data"]);
    }
    state.value = ButtonState.fail;
    return null;
  }
}
