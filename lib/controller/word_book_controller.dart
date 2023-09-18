import 'package:flutter/cupertino.dart';
import 'package:oncew_dict/common/local.dart';
import 'package:oncew_dict/dict/dict.dart';
import 'package:oncew_dict/service/api/word.dart';

import '../models/strategy.dart';
import '../models/word_book.dart';

const defaultWordsPerDay = 20;

/// 当前策略
class StrategyController extends ChangeNotifier {
  static StrategyController? _instance;

  StrategyController();

  static StrategyController getInstance() {
    _instance ??= StrategyController();
    return _instance!;
  }

  Strategy strategy = Strategy.byDefaults();

  bool get isUnset => strategy.wordBook.id == -99;

  setTodayList(List<Word> list) {
    onTodayListChanged?.call(list);
  }

  Function(List<Word>)? onTodayListChanged;

  /// 修改词书
  setWordBook(WordBook wordBook) {
    if (wordBook.id != strategy.wordBook.id) {
      strategy.wordBook = wordBook;
      strategy.wordsPerDay = defaultWordsPerDay;
      generateForToday();
    }
  }

  /// 修改每天单词数量
  setWordsPerDay(int value) {
    strategy.wordsPerDay = value;
    saveLocal();
  }

  /// 获取当天的单词列表
  Future<List<Word>> getToday() async {
    var res = await WordService.getWordsInWordBook({
      "word_book_id": strategy.wordBook.id,
      "user_id": strategy.userId,
    });
    if (res.isSuccess && res.data != null) {
      var list = (res.data["data"] as List<dynamic>)
          .map((e) => Word.fromMap(e))
          .toList();
      return list;
    }
    return [];
  }

  /// 初始化
  init(int userId) async {
    this.strategy.userId = userId;
    var strategy = await getLocal();
    if (strategy != null && strategy.userId == userId) {
      this.strategy = strategy;
      setTodayList(this.strategy.todayList);
    } else {
      this.strategy = Strategy.byDefaults();
      this.strategy.userId = userId;
    }

    if (!isUnset) {
      await generateForToday();
    }

    notifyListeners(); // 策略变更

  }

  /// 生成新的数据
  generateForToday() async {
    if (DateTime
        .now()
        .day - strategy.todayTime.day > 1 ||
        strategy.todayList.isEmpty) {
      var list = await getToday();
      var time = DateTime.now();
      strategy.todayTime = time;
      strategy.todayList = list;
      setTodayList(list);
      await saveLocal();
    }
  }

  saveLocal() async {
    await LocalData.setStringData<Strategy>(LocalData.strategyKey, strategy);
  }

  Future<Strategy?> getLocal() async {
    var mapData = await LocalData.getMapData(LocalData.strategyKey);
    if (mapData != null) {
      return Strategy.fromMap(mapData);
    }
    return null;
  }
}
