import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import 'create_controller.dart';

GlobalKey _formKey = GlobalKey<FormState>();

class CreateWordBookPage extends StatelessWidget {
  CreateWordBookPage({super.key});

  final userController = Get.find<UserController>();

  _submitForm(CreateWordBookController controller) async {
    bool success = await controller.createBook(userController.user.value.id);
    if (success) {
      EasyLoading.showToast("成功！");
    } else {
      EasyLoading.showToast("失败！");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("创建词书"),
      ),
      body: GetBuilder(
          init: CreateWordBookController(),
          builder: (controller) {
            return Center(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: '词书名称'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        controller.name.value = value;
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: '词书描述'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) controller.description.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _submitForm(controller),
                    child: Text('提交'),
                  ),
                ],
              ),
            ));
          }),
    );
  }
}
