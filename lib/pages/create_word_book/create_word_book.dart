import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/models/word_book.dart';
import 'package:oncew_dict/pages/word_book/word_book_controller.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../controller/user_controller.dart';
import 'create_controller.dart';

class CreateWordBookPage extends StatelessWidget {
  GlobalKey _formKey = GlobalKey<FormState>();

  CreateWordBookPage({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  final userController = Get.find<UserController>();
  final wordBookController = Get.find<WordBookController>();

  _submitForm(CreateWordBookController controller) async {
    if ((_formKey.currentState as FormState).validate()) {
      var wordBook = await controller.createBook(WordBook(
          id: -1,
          useId: userController.user.value.id,
          name: name.text,
          description: description.text,
          createdAt: DateTime.now().toString(),
          type: 1));
      if (wordBook != null) {
        wordBookController.workBookList.add(wordBook);
        Future.delayed(
            Duration(
              seconds: 1,
            ),
            () => Get.back());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateWordBookController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("创建词书"),
        ),
        body: Container(
          padding: EdgeInsets.all(30.w),
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: name,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: '词书名称'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入词书名称';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: description,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: '词书描述'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入词书描述';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => ProgressButton.icon(
                      state: controller.status.value,
                      onPressed: () => _submitForm(controller),
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text: "提交",
                            icon: const Icon(Icons.send, color: Colors.white),
                            color: Colors.blueAccent.shade400),
                        ButtonState.loading: IconedButton(
                            text: "正在提交", color: Colors.blueAccent.shade700),
                        ButtonState.fail: IconedButton(
                            text: "提交失败",
                            icon: const Icon(Icons.cancel, color: Colors.white),
                            color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "提交成功",
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            color: Colors.green.shade400)
                      })),
            ]),
          )),
        ));
  }
}
