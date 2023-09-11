import 'dart:convert';

import '../models/word.dart';
import 'dict.dart';

class ServiceDict extends Dict {
  ServiceDict({required super.name});

  @override
  Future<List<Word>> getAll() async {
    return [
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
    ];
  }

  @override
  queryWord(String word) {
    // TODO: implement queryWord
    throw UnimplementedError();
  }
}
