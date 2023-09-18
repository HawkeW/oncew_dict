import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/pages/strategy/strategy.dart';
import 'package:oncew_dict/pages/strategy/strategy_controller.dart';
import '../../controller/user_controller.dart';
import '../../controller/word_book_controller.dart';
import '../../controller/word_controller.dart';
import '../../widgets/home_drawer.dart';
import '../../widgets/word_card.dart';

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

final GlobalKey homeKey = GlobalKey();

class Home extends StatelessWidget {
  final controller = ScrollController();
  final userController = Get.put(UserController());
  final strategyController = Get.put(StrategyPageController());

  Home({super.key});

  buildMemoryCard(WordCardController wordController) {
    return Container(
        width: 1.sw,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Obx(
          () => Flex(direction: Axis.vertical, children: [
            if (wordController.current != null)
              Container(
                height: 1.sh - 200.w,
                child: WordCard(
                  word: wordController.current!,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      onPressed: () => wordController.prev(),
                      child: Text("我冇知")),
                ),
                SizedBox(width: 30.w),
                SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightGreen)),
                      onPressed: () => wordController.next(),
                      child: Text("我悟了")),
                ),
              ],
            ),
          ]),
        ));
  }

  @override
  Widget build(context) {
    final wordController = Get.put(WordCardController());
    return Scaffold(
      key: homeKey,
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: Obx(() => strategyController.isUnset.value
            ? Text(
                "请选定词书",
                style: TextStyle(fontSize: 16.sp),
              )
            : Text(strategyController.strategy.value.wordBook.name)),
        toolbarHeight: 50,
        leading: IconButton(
          onPressed: () {
            (homeKey.currentState as ScaffoldState).openDrawer();
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() => strategyController.isUnset.value
          ? Center(
              child: ElevatedButton(
                onPressed: () => Get.to(() => StrategyPage()),
                child: Text("配置策略"),
              ),
            )
          : buildMemoryCard(wordController)),
    );
  }
}
