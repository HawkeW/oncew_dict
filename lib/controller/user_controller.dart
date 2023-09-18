import 'package:get/get.dart';
import 'package:oncew_dict/common/local.dart';
import 'package:oncew_dict/models/user.dart';

class UserController extends GetxController {
  Rx<User> user = User(
          id: -99,
          nickName: '',
          phone: '',
          password: '',
          createdAt: DateTime.now())
      .obs;

  get isLogin => user.value.id != -99;

  @override
  void onInit() async {
    super.onInit();
    var mapData = await LocalData.getMapData(LocalData.userDataKey);
    if (mapData != null) {
      user.value = User.fromMap(mapData);
    }
  }

  setUser(User user) async {
    await LocalData.setStringData<User>(LocalData.userDataKey, user);
    this.user.value = user;
  }

  logOut() {
    setUser(User(
        id: -99,
        nickName: '',
        phone: '',
        password: '',
        createdAt: DateTime.now()));
  }
}
