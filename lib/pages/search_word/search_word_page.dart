import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oncew_dict/controller/user_controller.dart';
import 'package:oncew_dict/pages/search_word/search_word_controller.dart';
import 'package:oncew_dict/pages/word_detail/word_detail.dart';

import '../../dict/models/word.dart';
import '../../models/word_book.dart';
import '../word_book_detail/word_book_detail_controller.dart';

class SearchWordPage extends StatelessWidget {
  WordBook? wordBook;

  SearchWordPage({super.key, this.wordBook});

  final searchTextController = TextEditingController();

  Timer? _debounce;

  final userController = Get.find<UserController>();
  final controller = Get.put(SearchWordController());

  _debouncedSearch(String? keyword) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (keyword != null) {
        controller.searchByWord(keyword);
      }
    });
  }

  addTo() {}

  addWordToCurrentWordBook(Word word) async {
    if (wordBook != null) {
      final wordBookController = Get.find<WordBookDetailController>();
      await controller.addWordToBook(
          userController.user.value.id, wordBookController.wordBook, word);
      wordBookController.getWordList();
    }
  }

  getKeywordTitle(Word word, RxString keyword) {
    String processedStr = word.word.replaceAll(keyword, ',${keyword.value},');
    List<String> parts = processedStr.split(',');
    return RichText(
        text: TextSpan(
            children: parts
                .map((e) => TextSpan(
                    text: e,
                    style: TextStyle(
                        color: e.contains(keyword.value)
                            ? Colors.lightGreen
                            : Colors.black)))
                .toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                hintText: "请输入单词", hintStyle: TextStyle(color: Colors.white60)),
            controller: searchTextController,
            onChanged: _debouncedSearch,
          ),
        ),
        body: Container(
            height: 1.sh,
            child: Obx(
              () => ListView(
                children: [
                  if (controller.wordResult.isEmpty ||
                      searchTextController.text.isEmpty)
                    Center(heightFactor: 40, child: Text("请输入需要搜索的单词"))
                  else
                    ...controller.wordResult
                        .map((element) => Obx(() => ListTile(
                              onTap: () =>
                                  Get.to(WordDetailPage(word: element)),
                              title:
                                  getKeywordTitle(element, controller.keyword),
                              subtitle: element.captions?.isEmpty == true
                                  ? null
                                  : Text(element.captions?.first.defCn ?? "n"),
                              trailing: wordBook == null
                                  ? null
                                  : IconButton.outlined(
                                      onPressed: () =>
                                          addWordToCurrentWordBook(element),
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.blueAccent,
                                      )),
                            )))
                        .toList()
                ],
              ),
            )));
  }
}
