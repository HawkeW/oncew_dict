import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/pages/search_word/search_word_page.dart';
import 'package:oncew_dict/pages/word_book_detail/word_book_detail_controller.dart';
import 'package:oncew_dict/pages/word_detail/word_detail.dart';
import '../../models/word_book.dart';

class WordBookDetail extends StatelessWidget {
  WordBook wordBook;
  int userId;

  WordBookDetail({super.key, required this.wordBook, required this.userId});

  importWithAi() {}

  importByCsv() {}

  importSingle() {
    Get.to(() => SearchWordPage(wordBook: wordBook));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WordBookDetailController(wordBook, userId));

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
              wordBook.name,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              if (controller.wordList.isNotEmpty)
                TextButton(
                    onPressed: () => importSingle(),
                    child: Text(
                      "导入",
                      style: TextStyle(color: Colors.white),
                    ))
            ],
          ),
          body: Center(
            child: Obx(
              () => ListView(
                children: [
                  /// 描述
                  Container(
                    margin: EdgeInsets.all(10.w),
                    padding: EdgeInsets.all(20.w),
                    width: 1.sw,
                    height: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                      color: Colors.grey.shade400.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(5.w)),
                    ),
                    child: Text(
                      wordBook.description,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  if (controller.wordList.isEmpty)
                    Container(
                      padding: EdgeInsets.only(top: 20.w),
                      height: 1.sh - 120.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("暂无单词"),
                          Column(
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: ElevatedButton(
                                    onPressed: () => importWithAi(),
                                    child: Text("AI导入")),
                              ),
                              SizedBox(
                                width: 100.w,
                                child: ElevatedButton(
                                    onPressed: () => importSingle(),
                                    child: Text("手动添加")),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  else
                    ...controller.wordList.map((element) => ListTile(
                          onTap: () =>
                              Get.to(() => WordDetailPage(word: element)),
                          title: Text(element.word),
                          trailing: element.captions?.isNotEmpty == true
                              ? SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    "${element.captions!.first.stCn ?? ""} ${element.captions!.first.defCn ?? ""}",
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ))
                              : null,
                        )),
                ],
              ),
            ),
          ),
        ));
  }
}
