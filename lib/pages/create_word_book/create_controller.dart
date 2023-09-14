import 'package:get/get.dart';
import 'package:oncew_dict/service/api/word.dart';

class CreateWordBookController extends GetxController {
  RxString name = "".obs;
  RxString description = "".obs;

  Future<bool> createBook(int userId) async {
    final res =
        await WordService.createWordBook(userId, name.value, description.value);

    if (res.isSuccess && res.data["data"] != null) {
      return true;
    }
    return false;
  }
}
