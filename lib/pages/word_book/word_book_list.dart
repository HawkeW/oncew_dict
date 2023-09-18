import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/controller/user_controller.dart';
import 'package:oncew_dict/pages/word_book/word_book_list_controller.dart';
import '../create_word_book/create_word_book.dart';
import '../word_book_detail/word_book_detail.dart';

class WordBookListPage extends StatelessWidget {
  WordBookListPage({super.key});

  final userController = Get.find<UserController>();

  Widget getWordBookItem(WordBookListController controller, int index) {
    var item = controller.workBookList[index];
    return InkWell(
      onTap: () {
        if (controller.isMultiSelect.value) {
          controller.multiSelectChoice[index] =
              !controller.multiSelectChoice[index];
        } else {
          Get.to(() => WordBookDetail(
                wordBook: item,
                userId: userController.user.value.id,
              ));
        }
      },
      onLongPress: () => controller.setMultiSelect(true),
      child: ListTile(
        leading: controller.isMultiSelect.value
            ? Checkbox(
                value: controller.multiSelectChoice[index],
                onChanged: (bool? value) {
                  controller.multiSelectChoice[index] = value == true;
                },
              )
            : null,
        title: Text(item.name),
        subtitle: SizedBox(
          child: Text(
            item.description,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ),
        trailing: Text(item.createdAt.substring(0, 10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(WordBookListController(userController.user.value));
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: const Text("我的词书"),
            actions: [
              if (controller.isMultiSelect.value)
                TextButton(
                  onPressed: () {
                    controller.isMultiSelect.value = false;
                  },
                  child: Text(
                    "完成",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          floatingActionButton: controller.isMultiSelect.value
              ? FloatingActionButton(
                  backgroundColor: Colors.redAccent,
                  onPressed: () => controller.removeSelected(),
                  child: const Icon(
                    Icons.delete_outlined,
                    color: Colors.white,
                  ),
                )
              : FloatingActionButton(
                  onPressed: () => Get.to(() => CreateWordBookPage()),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
          body: GetX<WordBookListController>(builder: (controller) {
            if (controller.loading.value) {
              return const Center(
                child: Text("加载中..."),
              );
            }
            if (controller.workBookList.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("暂无数据"),
                  SizedBox(
                    height: 20.w,
                  ),
                  ElevatedButton(
                      onPressed: () => Get.to(() => CreateWordBookPage()),
                      child: const Text("添加词书")),
                ],
              ));
            }
            return Obx(() => ListView(
                  children: controller.workBookList
                      .asMap()
                      .keys
                      .map((index) {
                        return getWordBookItem(controller, index);
                      })
                      .toList()
                      .reversed
                      .toList(),
                ));
          }),
        ));
  }
}
