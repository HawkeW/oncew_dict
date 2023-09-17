import 'dart:convert';

import '../models/word.dart';
import 'dict.dart';

/// 服务接口词典
class ServiceDict extends Dict {
  ServiceDict({required super.name});

  @override
  Future<List<Word>> getAll() async {
    return [
      Word(
          id: 0,
          word: "man",
          pronounceUk: "[{\"pron\": \"man\"}]",
          captions: jsonEncode([
            {
              "sentences": [
                {"en": "I don't like noodles at all"},
                {"en": "I like noodles very much"},
              ]
            },
          ])),
      Word(id: 1, word: "24-7"),
      Word(id: 2, word: "shit"),
      Word(
          id: 3,
          word: "noodle",
          pronounceUk: "[{\"pron\": \"noodle\"}]",
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

  @override
  queryWord(String word) {
    // TODO: implement queryWord
    throw UnimplementedError();
  }
}
