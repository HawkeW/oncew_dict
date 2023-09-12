import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/controller/user_controller.dart';

import '../pages/login/login_page.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('我的'),
        ),
        if (!userController.isLogin)
          ElevatedButton(
              onPressed: () => Get.to(() => LoginPage()), child: Text("登录"))
      ],
    ));
  }
}
