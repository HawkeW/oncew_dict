import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/word_controller.dart';
import '../../widgets/home_drawer.dart';
import '../../widgets/word_card.dart';
import '../user/user.dart';

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

final GlobalKey homeKey = GlobalKey();

class Home extends StatelessWidget {
  final controller = ScrollController();

  Home({super.key});

  @override
  Widget build(context) {
    final wordController = Get.put(WordCardController());
    return Scaffold(
      key: homeKey,
      drawer: HomeDrawer(),
      appBar: AppBar(
        title: Text(
          "当前词书",
          style: TextStyle(fontSize: 16.sp),
        ),
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
      body: Container(
          width: 1.sw,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Flex(
            direction: Axis.vertical,
            children: [
              if (wordController.current != null)
                Container(
                  height: 1.sh - 200.w,
                  child: Obx(() => WordCard(
                        word: wordController.current!,
                      )),
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
            ],
          )),
    );
  }
}
