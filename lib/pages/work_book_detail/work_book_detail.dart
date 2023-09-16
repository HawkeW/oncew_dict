import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/pages/word_book/word_book_controller.dart';
import 'package:oncew_dict/pages/work_book_detail/work_book_detail_controller.dart';

import '../../models/word_book.dart';

class WorkBookDetail extends StatelessWidget {
  WordBook wordBook;
  int userId;

  WorkBookDetail({super.key, required this.wordBook, required this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WorkBookDetailController(wordBook, userId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          wordBook.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            /// 描述
            Container(
              margin: EdgeInsets.all(10.w),
              padding: EdgeInsets.all(20.w),
              width: 1.sw,
              height: 100.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 6), // changes position of shadow
                  ),
                ],
                color: Colors.grey.shade400.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(5.w)),
              ),
              child: Text(
                wordBook.description,
                style: TextStyle(color: Colors.blue),
              ),
            ),
            if (controller.wordList.isEmpty) Text("暂无数据") else ...[],
          ],
        ),
      ),
    );
  }
}
