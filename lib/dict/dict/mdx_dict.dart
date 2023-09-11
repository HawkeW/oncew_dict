import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mdict_reader/mdict_reader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
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
}
