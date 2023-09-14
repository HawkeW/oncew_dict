import 'package:get/get.dart';
import 'package:oncew_dict/models/user.dart';

import '../../models/word_book.dart';
import '../../service/api/word.dart';

class WordBookController extends GetxController {
  RxList<WordBook> workBookList = (<WordBook>[]).obs;

  User user;

  WordBookController(User this.user);

  @override
  void onInit() {
    super.onInit();
    getWorkBookList();
  }

  setUser(User user) {
    this.user = user;
  }

  getWorkBookList() async {
    final res = await WordService.getUserWorkBooks(user!.id);
    if (res.isSuccess && res.data["data"] != null) {
      workBookList.value = (res.data["data"] as List<dynamic>)
          .map((e) => WordBook.fromMap(e))
          .toList();
    }
  }
}
