import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/pages/strategy/strategy_controller.dart';
import 'package:oncew_dict/pages/word_book/word_book_list_controller.dart';

import '../../controller/user_controller.dart';

class StrategyPage extends StatelessWidget {
  StrategyPage({super.key});

  final userController = Get.find<UserController>();

  showSelections(StrategyPageController controller) async {
    final wordBookListController =
        Get.put(WordBookListController(userController.user.value));
    await wordBookListController.getWorkBookList();
    Get.dialog(SimpleDialog(
      children: wordBookListController.workBookList
          .map((element) => SimpleDialogOption(
                child: Text(element.name),
                onPressed: () {
                  Get.back();
                  controller.setWordBook(element);
                },
              ))
          .toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("策略配置")),
        body: GetBuilder<StrategyPageController>(
          init: StrategyPageController(),
          builder: (controller) {
            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Text("当前词书"),
                      width: 200.w,
                    ),
                    Obx(() => ElevatedButton(
                        onPressed: () => showSelections(controller),
                        child: controller.isUnset.value
                            ? Text("未配置")
                            : Text(controller.strategy.value.wordBook.name)))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Text("单日数量"),
                      width: 200.w,
                    ),
                    Container(
                      width: 1.sw - 300.w,
                      child: Form(
                          child: TextFormField(
                        initialValue: controller.wordsPerDay.value.toString(),
                        textInputAction: TextInputAction.done,
                        validator: (String? value) {
                          var data = int.tryParse(value ?? "");
                          if (data == null) {
                            return "请输入数字";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.wordsPerDay.value = int.parse(value);
                        },
                        onEditingComplete: () {
                          controller
                              .setWordsPerDay(controller.wordsPerDay.value);
                          FocusScope.of(context).unfocus();
                        },
                      )),
                    )
                  ],
                ),
              ],
            );
          },
        ));
  }
}
