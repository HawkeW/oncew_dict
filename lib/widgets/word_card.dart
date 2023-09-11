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
