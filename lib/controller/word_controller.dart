import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../dict/dict.dart';
import '../dict/dict/dict.dart';
import '../gen/assets.gen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class WordCardController extends GetxController {
  late Dict _dict;

  @override
  onInit() async {
    Directory directory = await getApplicationDocumentsDirectory();
    debugPrint(directory.path);
    var dbPath = join(directory.path, "colinsCnEnHighCompact.mdx");
    ByteData data =
        await rootBundle.load(ResAssets.dicts.colinsCnEnHighCompact);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    _dict = Dict(path: dbPath, name: "柯林斯中英", type: "cn");
  }

  RxList<Word> list = (<Word>[
    Word(
        id: 0,
        word: "man",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[man]",
        sentenceList: ["I am a man", "I am not a man"]),
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
        sentenceList: [
          "I don't like noodles at all",
          "I like noodles very much",
        ]),
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
