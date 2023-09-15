import 'package:get/get.dart';
import 'package:oncew_dict/service/api/word.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../models/word_book.dart';

extension ButtonStatus on RxStatus {
  getButtonState() {
    if (isSuccess) return ButtonState.success;
    if (isEmpty) return ButtonState.idle;
    if (isError) return ButtonState.fail;
    if (isLoading) return ButtonState.loading;
    if (isLoadingMore) return ButtonState.loading;
  }
}

class CreateWordBookController extends GetxController {
  Rx<ButtonState> status = ButtonState.idle.obs;

  Future<WordBook?> createBook(WordBook data) async {
    status.value = ButtonState.loading;
    final res = await WordService.createWordBook(data.toMap());
    if (res.isSuccess && res.data["data"] != null) {
      await Future.delayed(
          const Duration(seconds: 1), () => status.value = ButtonState.success);
      return WordBook.fromMap(res.data["data"]);
    } else {
      await Future.delayed(
          const Duration(seconds: 1), () => status.value = ButtonState.fail);

      return null;
    }
  }
}
