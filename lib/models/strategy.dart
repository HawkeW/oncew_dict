import 'package:oncew_dict/common/local.dart';
import 'package:oncew_dict/models/word_book.dart';

import '../dict/models/word.dart';

class Strategy extends MappableData {
  int userId;
  WordBook wordBook;
  int wordsPerDay;
  DateTime todayTime;
  List<Word> todayList;

  Strategy({
    required this.userId,
    required this.wordBook,
    required this.wordsPerDay,
    required this.todayTime,
    required this.todayList,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'wordBook': wordBook.toMap(),
      'wordsPerDay': wordsPerDay,
      'todayTime': todayTime.toString(),
      'todayList': todayList.map((e) => e.toMap()).toList(),
    };
  }

  factory Strategy.fromMap(Map<String, dynamic> map) {
    return Strategy(
      userId: map['userId'] as int,
      wordBook: WordBook.fromMap(map['wordBook'] as Map<String, dynamic>),
      wordsPerDay: map['wordsPerDay'] as int,
      todayTime: DateTime.parse(map['todayTime'] as String),
      todayList: (map['todayList'] as List<dynamic>)
          .map((e) => Word.fromMap(e))
          .toList(),
    );
  }

  factory Strategy.byDefaults() {
    return Strategy(
        userId: -99,
        todayTime: DateTime.now(),
        todayList: [],
        wordBook: WordBook(
            userId: -99,
            id: -99,
            type: 1,
            name: '',
            description: '',
            createdAt: ''),
        wordsPerDay: 20);
  }
}
