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
        body: Center(
            child: Container(
      width: 300.w,
      height: 300.w,
      child: LayoutBuilder(
        builder: (ctx, constrains) {
          return SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constrains.maxWidth,
                  minHeight: constrains.maxHeight),
              child: Row(
                  children: wordController.list.map((e) {
                return Column(
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constrains.maxWidth,
                          minHeight: constrains.maxHeight * 0.6,
                        ),
                        child: WordCard(
                          word: e,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => wordController.prev(),
                            child: Text("前一个")),
                        ElevatedButton(
                            onPressed: () => wordController.next(),
                            child: Text("下一个")),
                      ],
                    ),
                  ],
                );
              }).toList()),
            ),
          );
        },
      ),
    )));
  }
}
