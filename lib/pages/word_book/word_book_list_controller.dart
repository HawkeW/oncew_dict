import 'package:get/get.dart';
import 'package:oncew_dict/models/user.dart';

import '../../models/word_book.dart';
import '../../service/api/word.dart';

class WordBookListController extends GetxController {
  RxList<WordBook> workBookList = (<WordBook>[]).obs;

  RxBool isMultiSelect = false.obs;

  RxList<bool> multiSelectChoice = (<bool>[]).obs;

  setMultiSelect(bool state) {
    multiSelectChoice.value = workBookList.map((element) => false).toList();
    if (state) {
      isMultiSelect.value = state;
    }
  }

  removeSelected() async {
    List<int> selectedBookIds = [];
    multiSelectChoice
        .asMap()
        .keys
        .forEach((index) {
      print(multiSelectChoice[index]);

      if (multiSelectChoice[index]) {
        selectedBookIds.add(workBookList[index].id);
      }
    });
    var res = await WordService.batchDeleteWordBook({
      "user_id": user.id,
      "ids": selectedBookIds.toList(),
    });
    if (res.isSuccess) {
      workBookList
          .removeWhere((element) => selectedBookIds.contains(element.id));
      setMultiSelect(true);
    }
  }

  RxBool loading = false.obs;

  User user;

  WordBookListController(User this.user);

  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    await getWorkBookList();

    Future.delayed(Duration(seconds: 1), () => loading.value = false);
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
