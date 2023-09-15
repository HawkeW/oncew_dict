import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/dict/dict/service_dict.dart';
import '../dict/dict.dart';
import '../dict/dict/dict.dart';

class WordCardController extends GetxController {
  late Dict _dict;

  @override
  onInit() async {
    _dict = ServiceDict(name: "柯林斯中英");
    list.value = await _dict.getAll();
  }

  RxList<Word> list = (<Word>[]).obs;

  RxInt index = 0.obs;

  Word? get current => list.value.isEmpty ? null : list[index.value];

  next() {
    if (index.value < list.length - 1) {
      index.value++;
      update();
    }
  }

  prev() {
    if (index.value > 0) {
      index.value--;
      update();
    }
  }
}
