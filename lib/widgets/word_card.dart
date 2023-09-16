import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../dict/dict.dart';

class WordCard extends StatelessWidget {
  final Word word;

  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    var sentenceIndex = 0;
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
                  fontFamily: 'Chromate'),
            ),
          ),
          if (word.pronounceUs != null)
            Text(
              "美音：${word.pronounceUs!}",
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
          if (word.pronounceUk != null)
            Text(
              "英音：${word.pronounceUk!}",
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
          SizedBox(
            height: 60.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: word.captions?.map((WordCaption e) {
                  sentenceIndex++;
                  return Text(
                    "例$sentenceIndex: ${e.sentences}",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  );
                }).toList() ??
                [],
          ),
        ],
      ),
    );
  }
}
