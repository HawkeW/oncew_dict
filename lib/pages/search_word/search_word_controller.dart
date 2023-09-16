import 'package:get/get.dart';

import '../../dict/models/word.dart';
import '../../models/word_book.dart';
import '../../service/api/word.dart';

class SearchWordController extends GetxController {
  RxList<Word> wordResult = (<Word>[]).obs;

  RxString keyword = "".obs;

  searchByWord(String wordLike) async {
    wordResult.clear();
    keyword.value = wordLike;
    var res = await WordService.searchWords({"word": wordLike});
    if (res.isSuccess && res.data["data"] != null) {
      List<Word> data = (res.data["data"] as List<dynamic>)
          .map((data) => Word.fromMap(data))
          .toList();
      wordResult.value = data;
    } else {
      print("获取单词失败");
    }
  }

  addWordToBook(int userId, WordBook wordBook, Word word) async {
    var res = await WordService.addWordToWordBook({
      "words": [word.word],
      "word_book_id": wordBook.id,
      "user_id": userId,
    });
    if (res.isSuccess && res.data["data"] != null) {
      print("添加单词成功");
    } else {
      print("添加单词失败");
    }
  }
}
