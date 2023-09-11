import 'dart:convert';

class Word {
  num id;
  String word;
  String dictId;
  String dictName;
  String? pronounceUk;
  String? pronounceUs;
  List<WordCaption>? captions;

  Word({
    required this.id,
    required this.word,
    required this.dictId,
    required this.dictName,
    this.pronounceUk,
    this.pronounceUs,
    String? captions,
  }) {
    if (captions != null) {
      List<dynamic> captionsData = jsonDecode(captions);
      this.captions = captionsData.map((e) => WordCaption.fromMap(e)).toList();
    }
  }
}

class WordCaption {
  String sentence;

  WordCaption({
    required this.sentence,
  });

  Map<String, dynamic> toMap() {
    return {
      'sentence': sentence,
    };
  }

  factory WordCaption.fromMap(Map<String, dynamic> map) {
    return WordCaption(
      sentence: map['sentence'] as String,
    );
  }
}
