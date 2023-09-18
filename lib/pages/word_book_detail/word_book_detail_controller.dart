import 'package:get/get.dart';
import 'package:oncew_dict/service/api/word.dart';

import '../../dict/models/word.dart';
import '../../models/word_book.dart';

class WordBookDetailController extends GetxController {
  WordBook wordBook;
  int userId;

  WordBookDetailController(this.wordBook, this.userId);

  @override
  onInit() {
    super.onInit();
    getWordList();
  }

  RxList<Word> wordList = (<Word>[]).obs;

  getWordList() async {
    final res = await WordService.getWordsInWordBook({
      "word_book_id": wordBook.id,
      "user_id": userId,
    });
    if (res.isSuccess) {
      wordList.value = (res.data["data"] as List<dynamic>)
          .map((e) => Word.fromMap(e))
          .toList();
    }
  }
}
