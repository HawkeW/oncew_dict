import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/controller/user_controller.dart';
import 'package:oncew_dict/pages/word_book/word_book.dart';

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
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!userController.isLogin)
                Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                )
              else
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                      Text(userController.user.value.nickName),
                      Text(userController.user.value.phone),
                    ],
                  ),
                )
            ],
          ),
        ),
        if (!userController.isLogin)
          ElevatedButton(
              onPressed: () => Get.to(() => LoginPage()), child: Text("登录"))
        else ...[
          ListTile(
              title: ElevatedButton(
            child: Text(
              "我的词书",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Get.to(() => WordBookPage()),
          ))
        ]
      ],
    ));
  }
}
