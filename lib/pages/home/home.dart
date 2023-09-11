import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/word_controller.dart';
import '../../widgets/word_card.dart';

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

class Home extends StatelessWidget {
  final controller = ScrollController();

  @override
  Widget build(context) {
    final wordController = Get.put(WordCardController());
    return Scaffold(
      // 用一个简单的Get.to()即可代替Navigator.push那8行，无需上下文！
      body: Container(
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
