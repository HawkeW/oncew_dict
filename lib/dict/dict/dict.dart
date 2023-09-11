import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mdict_reader/mdict_reader.dart';
import 'package:path/path.dart';

class Dict {
  String name;
  String path;
  String? type;

  late MdictReader _mdict;

  Dict({
    required this.name,
    required this.path,
    this.type,
  }) {
    _mdict = MdictReader(path);
  }

  queryWord(String word) {
    final result = _mdict.query(word);
    debugPrint(result);
  }
}
