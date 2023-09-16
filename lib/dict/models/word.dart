import 'dart:convert';

class Word {
  num id;
  String word;
  String? pronounceUk;
  String? pronounceUs;
  List<WordCaption>? captions;

  Word({
    required this.id,
    required this.word,
    this.pronounceUk,
    this.pronounceUs,
    String? captions,
  }) {
    if (captions != null) {
      List<dynamic> captionsData = jsonDecode(captions);
      this.captions = captionsData.map((e) => WordCaption.fromMap(e)).toList();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'pronounceUk': pronounceUk,
      'pronounceUs': pronounceUs,
      'captions': captions,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'] as num,
      word: map['word'] as String,
      pronounceUk: map['pron_uk'] as String,
      pronounceUs: map['pron_us'] as String,
      captions: map['captions'],
    );
  }
}

class WordCaption {
  String? st;
  String? stCn;
  String? defCn;
  String? defEn;
  List<SentenceWithTranslate>? sentences;

  WordCaption({
    this.st,
    this.stCn,
    this.defCn,
    this.defEn,
    this.sentences,
  });

  Map<String, dynamic> toMap() {
    return {
      "st": st,
      "stCn": stCn,
      "defCn": defCn,
      "defEn": defEn,
      'sentence': sentences,
    };
  }

  factory WordCaption.fromMap(Map<String, dynamic> map) {
    return WordCaption(
      sentences: (map['sentence'] as List<Map<String, dynamic>>?)
          ?.map((e) => SentenceWithTranslate.fromMap(e))
          .toList(),
      st: map['st'] as String?,
      stCn: map['stCn'] as String?,
      defCn: map['defCn'] as String?,
      defEn: map['defEn'] as String?,
    );
  }
}

class SentenceWithTranslate {
  String? en;
  String? cn;

  SentenceWithTranslate({this.en, this.cn});

  Map<String, dynamic> toMap() {
    return {
      'en': en,
      'cn': cn,
    };
  }

  factory SentenceWithTranslate.fromMap(Map<String, dynamic> map) {
    return SentenceWithTranslate(
      en: map['en'] as String,
      cn: map['cn'] as String,
    );
  }
}
