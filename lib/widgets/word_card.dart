import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dict/dict.dart';
import '../gen/fonts.gen.dart';

class WordCard extends StatelessWidget {
  final Word word;

  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 60.w),
            child: Text(
              word.word,
              style: TextStyle(
                  fontSize: 80.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.chromate),
            ),
          ),
          if (word.pronounceUs.isNotEmpty)
            Text(
              "美音：${word.pronounceUs.first.pron}",
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
          if (word.pronounceUk.isNotEmpty)
            Text(
              "英音：${word.pronounceUk.first.pron}",
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
          SizedBox(
            height: 60.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: word.captions?.isNotEmpty == true
                ? word.captions!.first.sentences?.asMap().keys.map((index) {
                      var val = word.captions!.first.sentences![index];
                      return Text(
                        "例${index + 1}\n${val.en}\n${val.cn}",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      );
                    }).toList() ??
                    []
                : [],
          ),
        ],
      ),
    );
  }
}
