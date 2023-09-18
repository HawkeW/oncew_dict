import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/controller/user_controller.dart';
import 'package:oncew_dict/pages/login/login_controller.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FocusNode passwordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final loginController = Get.put(LoginController());
  final userController = Get.find<UserController>();

  void _submitForm() async {
    if ((_formKey.currentState as FormState).validate()) {
      _formKey.currentState!.save();
      var user = await loginController.login();
      if (user != null) {
        await userController.setUser(user);
        await Future.delayed(Duration(seconds: 2));
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Container(
        height: 1.sh,
        padding: EdgeInsets.all(16.0),
        child: Center(
          heightFactor: 1.sh,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: '手机号'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  onSaved: (value) {
                    if (value != null) {
                      loginController.phone.value = value;
                    }
                  },
                ),
                TextFormField(
                  focusNode: passwordFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '密码',
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    _submitForm();
                  },
                  onSaved: (value) {
                    if (value != null) loginController.password.value = value;
                  },
                ),
                SizedBox(height: 16),
                Obx(() => ProgressButton.icon(
                        state: loginController.state.value,
                        onPressed: () => _submitForm(),
                        iconedButtons: {
                          ButtonState.idle: IconedButton(
                              text: "登录",
                              icon: const Icon(Icons.login_sharp,
                                  color: Colors.white),
                              color: Colors.blueAccent.shade400),
                          ButtonState.loading: IconedButton(
                              text: "正在登录", color: Colors.blueAccent.shade700),
                          ButtonState.fail: IconedButton(
                              text: "登录失败",
                              icon:
                                  const Icon(Icons.cancel, color: Colors.white),
                              color: Colors.red.shade300),
                          ButtonState.success: IconedButton(
                              text: "登录成功",
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400)
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
