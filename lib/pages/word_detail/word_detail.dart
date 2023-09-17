import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oncew_dict/gen/assets.gen.dart';
import 'package:oncew_dict/pages/word_detail/word_detail_controller.dart';

import '../../dict/models/word.dart';
import '../../gen/fonts.gen.dart';

class Theme {
  static Color wordBackground = Color(0xffcaf0f8);
  static Color wordTitle = Color(0xff03045e);
  static Color wordSt = Color(0xfffca311);
  static Color wordDef = Color(0xff14213d);
}

class WordDetailPage extends StatelessWidget {
  final Word word;

  final controller = Get.put(WordDetailController());

  WordDetailPage({super.key, required this.word});

  buildCaption(bool isCN) {
    return word.captions!
        .map((e) => Column(
              children: [
                RichText(
                  text: TextSpan(children: [
                    if (isCN && e.stCn != null)
                      TextSpan(
                        text: "${e.stCn!} ",
                        style: TextStyle(color: Theme.wordSt),
                      ),
                    if (isCN && e.defCn != null)
                      TextSpan(
                        text: e.defCn!,
                        style: TextStyle(color: Theme.wordDef),
                      ),
                    if (!isCN && e.st != null)
                      TextSpan(
                        text: "${e.st!} ",
                        style: TextStyle(color: Theme.wordSt),
                      ),
                    if (!isCN && e.defEn != null)
                      TextSpan(
                        text: e.defEn!,
                        style: TextStyle(color: Theme.wordDef),
                      ),
                  ]),
                ),
                if (e.sentences != null)
                  RichText(
                      text: TextSpan(
                          children: e.sentences!
                              .map((e) => TextSpan(text: isCN ? e.cn : e.en))
                              .toList()))
              ],
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单词详情"),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: controller.isShowCn.value ? Text("英文") : Text("中文"),
            onPressed: () {
              controller.isShowCn.value = !controller.isShowCn.value;
            },
          )),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10.w),
            padding: EdgeInsets.all(10.w),
            width: 1.sw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: Theme.wordBackground.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Theme.wordBackground.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 6), // changes position of shadow
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  word.word,
                  style: TextStyle(
                      color: Theme.wordTitle,
                      fontSize: 36.sp,
                      fontFamily: FontFamily.chromate),
                ),
                Obx(() => AnimatedIconButton(
                    animating: controller.isBroadCasting.value,
                    onTap: () {
                      controller.isBroadCasting.value =
                          !controller.isBroadCasting.value;
                    })),
                Column(
                  children: [
                    Text("美音"),
                    Text(word.pronounceUs.map((e) => "[${e.pron}]").join('\n')),
                    Text("英音"),
                    Text(word.pronounceUk.map((e) => "[${e.pron}]").join('\n')),
                  ],
                )
              ],
            ),
          ),
          if (word.captions != null)
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("释义"),
                          ],
                        ),
                        ...buildCaption(controller.isShowCn.value),
                      ],
                    ))),
        ],
      ),
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  final bool animating;
  final Function() onTap;

  const AnimatedIconButton(
      {super.key, required this.animating, required this.onTap});

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    animation =
        Tween(begin: 0.0, end: icons.length.toDouble()).animate(_controller);
    if (widget.animating) {}
  }

  List<AssetGenImage> get icons {
    return ResAssets.animate.voice.values;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return icons[animation.value.toInt()]
                  .image(width: 30.w, height: 30.w);
            }),
      ),
    );
  }
}
