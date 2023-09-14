import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/controller/user_controller.dart';
import 'package:oncew_dict/pages/word_book/word_book_controller.dart';

import '../create_word_book/create_word_book.dart';

class WordBookPage extends StatelessWidget {
  WordBookPage({super.key});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的词书"),
      ),
      body: GetX<WordBookController>(
          init: WordBookController(userController.user.value),
          builder: (controller) {
            if (controller.workBookList.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("暂无数据"),
                  SizedBox(
                    height: 20.w,
                  ),
                  ElevatedButton(
                      onPressed: () => Get.to(() => CreateWordBookPage()),
                      child: Text("添加词书")),
                ],
              ));
            }
            return ListView(
              children: controller.workBookList.value
                  .map((item) => ListTile(
                        title: Text(item.name),
                        trailing:
                            Text(DateTime.parse(item.createdAt).toString()),
                      ))
                  .toList(),
            );
          }),
    );
  }
}
