import 'dart:convert';

import 'package:get/get.dart';
import '../dict/dict.dart';
import '../dict/dict/dict.dart';

class WordCardController extends GetxController {
  late Dict _dict;

  @override
  onInit() async {}

  RxList<Word> list = (<Word>[
    Word(
        id: 0,
        word: "man",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[man]",
        captions: jsonEncode([
          {"sentence": "I am a man"},
          {"sentence": "I am not a man"}
        ])),
    Word(
        id: 1,
        word: "24-7",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[woman]"),
    Word(
        id: 2,
        word: "shit",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[shit]"),
    Word(
        id: 3,
        word: "noodle",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[noodle]",
        captions: jsonEncode([
          {"sentence": "I don't like noodles at all"},
          {"sentence": "I like noodles very much"},
        ])),
  ]).obs;

  RxInt index = 0.obs;

  Word get current => list[index.value];

  next() {
    if (index.value < list.length - 1) {
      index.value++;
      _dict.queryWord(current.word);
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
