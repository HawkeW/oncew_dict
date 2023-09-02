import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(375, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: Home(),
    );
  }
}

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

class Word {
  num id;
  String word;
  String dictId;
  String dictName;
  String? pronounceUk;
  String? pronounceUs;
  List<String>? sentenceList;

  Word({
    required this.id,
    required this.word,
    required this.dictId,
    required this.dictName,
    this.pronounceUk,
    this.pronounceUs,
    this.sentenceList,
  });
}

class WordCardController extends GetxController {
  RxList<Word> list = (<Word>[
    Word(
        id: 0,
        word: "man",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[man]",
        sentenceList: ["I am a man", "I am not a man"]),
    Word(
        id: 1,
        word: "woman",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[woman]"),
    Word(
        id: 2,
        word: "shit",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[shit]"),
    Word(
        id: 3,
        word: "noodle",
        dictId: "uk",
        dictName: "柯林斯词典",
        pronounceUk: "[noodle]",
        sentenceList: [
          "I don't like noodles at all",
          "I like noodles very much",
        ]),
  ]).obs;

  RxInt index = 0.obs;

  Word get current => list[index.value];

  next() {
    if (index.value < list.length - 1) {
      index.value++;
      update();
    }
  }

  prev() {
    if (index.value > 0) {
      index.value--;
      update();
    }
  }
}

class WordCard extends StatelessWidget {
  final Word word;

  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    var sentenceIndex = 0;
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(5.w)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              word.word,
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Chromate'),
            ),
            Text(
              word.dictName,
            ),
            if (word.pronounceUs != null)
              Text(
                "美音：${word.pronounceUs!}",
              ),
            if (word.pronounceUk != null)
              Text(
                "英音：${word.pronounceUk!}",
              ),
            ...(word.sentenceList?.map((e) {
                  sentenceIndex++;
                  return Text("例$sentenceIndex: $e");
                }).toList() ??
                [])
          ],
        ),
      ),
    );
  }
}
