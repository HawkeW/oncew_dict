import '../models/word.dart';

abstract class Dict {
  String name;
  String? type;

  Dict({
    required this.name,
    this.type,
  });

  queryWord(String word);

  Future<List<Word>> getAll();
}
