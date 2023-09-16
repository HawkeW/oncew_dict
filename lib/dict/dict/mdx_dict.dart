import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mdict_reader/mdict_reader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/word.dart';
import './dict.dart';

class MdxDict extends Dict {
  late MdictReader _mdict;

  String path;

  MdxDict({required super.name, required this.path});

  onInit() async {
    Directory directory = await getApplicationDocumentsDirectory();
    debugPrint(directory.path);
    var dbPath = join(directory.path, "colinsCnEnHighCompact.mdx");
    _mdict = MdictReader(dbPath);
  }

  @override
  queryWord(String word) {
    final result = _mdict.query(word);
    debugPrint(result);
  }

  @override
  Future<List<Word>> getAll() async {
    return [
      Word(
          id: 0,
          word: "man",
          pronounceUk: "[man]",
          captions: jsonEncode([
            {
              "sentences": [
                {"en": "I don't like noodles at all"},
                {"en": "I like noodles very much"},
              ]
            },
          ])),
      Word(id: 1, word: "24-7", pronounceUk: "[woman]"),
      Word(id: 2, word: "shit", pronounceUk: "[shit]"),
      Word(
          id: 3,
          word: "noodle",
          pronounceUk: "[noodle]",
          captions: jsonEncode([
            {
              "sentences": [
                {"en": "I don't like noodles at all"},
                {"en": "I like noodles very much"},
              ]
            },
          ])),
    ];
  }
}
