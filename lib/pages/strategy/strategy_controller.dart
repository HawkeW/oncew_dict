import 'package:get/get.dart';
import 'package:oncew_dict/controller/word_book_controller.dart';

import '../../models/strategy.dart';
import '../../models/word_book.dart';

class StrategyPageController extends GetxController {
  StrategyController controller = StrategyController.getInstance();

  Rx<Strategy> strategy = StrategyController.getInstance().strategy.obs;

  RxBool isUnset = StrategyController.getInstance().isUnset.obs;

  RxInt wordsPerDay = StrategyController.getInstance().strategy.wordsPerDay.obs;

  @override
  onInit() {
    super.onInit();
    controller.addListener(() {
      strategy.value = controller.strategy;
      isUnset.value = controller.isUnset;
      wordsPerDay.value = controller.strategy.wordsPerDay;
    });
  }

  /// 修改词书
  setWordBook(WordBook wordBook) {
    if (strategy.value.wordBook.id != wordBook.id) {
      controller.setWordBook(wordBook);
      strategy.value = controller.strategy;
      isUnset.value = controller.isUnset;
      wordsPerDay.value = controller.strategy.wordsPerDay;
      update();
    }
  }

  setWordsPerDay(int value) {
    controller.setWordsPerDay(value);
    update();
  }
}
