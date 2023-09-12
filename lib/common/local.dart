import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class MappableData {
  Map<String, dynamic> toMap();
}

class LocalData {
  static const userDataKey = "user_data_key";

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<Map<String, dynamic>?> getMapData(String key) async {
    var sp = await _prefs;
    var mappedStringData = sp.getString(key);
    if (mappedStringData == null) return null;
    return jsonDecode(mappedStringData);
  }

  static setStringData<T extends MappableData>(String key, T value) async {
    var sp = await _prefs;
    var strData = jsonEncode(value.toMap());
    sp.setString(key, strData);
  }
}
