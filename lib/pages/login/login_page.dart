import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/controller/user_controller.dart';
import 'package:oncew_dict/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final loginController = Get.put(LoginController());
  final userController = Get.find<UserController>();

  void _submitForm() async {
    if ((_formKey.currentState as FormState).validate()) {
      _formKey.currentState!.save();
      var user = await loginController.login();
      if (user != null) {
        await userController.setUser(user);
        EasyLoading.showToast("登录成功！");
      } else {
        EasyLoading.showToast("登录失败！");
      }
      print('phone: ${loginController.phone.value}');
      print('Password: ${loginController.password.value}');
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
                  onSaved: (value) {
                    if (value != null) {
                      loginController.phone.value = value;
                    }
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: '密码'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) loginController.password.value = value;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('登录'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
