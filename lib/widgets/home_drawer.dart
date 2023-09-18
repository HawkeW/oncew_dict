import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/controller/user_controller.dart';
import 'package:oncew_dict/pages/word_book/word_book_list.dart';

import '../pages/login/login_page.dart';
import '../pages/search_word/search_word_page.dart';
import '../pages/strategy/strategy.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final userController = Get.find<UserController>();

  buildDrawerItem(String title, IconData icon, [Function()? onTap]) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w)),
        tileColor: Colors.blue,
        style: ListTileStyle.drawer,
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Obx(() => ListView(
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
                      onPressed: () => Get.to(() => LoginPage()),
                      child: Text("登录"))
                else
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            buildDrawerItem(
                              "策略配置",
                              Icons.sticky_note_2,
                              () => Get.to(() => StrategyPage()),
                            ),
                            buildDrawerItem(
                              "所有词书",
                              Icons.book,
                              () => Get.to(() => WordBookListPage()),
                            ),
                            buildDrawerItem(
                              "搜索单词",
                              Icons.search,
                              () => Get.to(() => SearchWordPage()),
                            ),
                            buildDrawerItem("退出登录", Icons.logout,
                                () => userController.logOut()),
                          ],
                        ),
                      ],
                    ),
                  )
              ],
            )));
  }
}
