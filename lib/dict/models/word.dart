import 'dart:convert';

class Word {
  num id;
  String word;
  late List<WordPron> pronounceUk;
  late List<WordPron> pronounceUs;
  List<WordCaption>? captions;

  Word({
    required this.id,
    required this.word,
    String? pronounceUk,
    String? pronounceUs,
    String? captions,
  }) {
    if (captions != null) {
      List<dynamic> captionsData = jsonDecode(captions);
      this.captions = captionsData.map((e) => WordCaption.fromMap(e)).toList();
    }
    if (pronounceUs != null) {
      List<dynamic> data = jsonDecode(pronounceUs);
      this.pronounceUs = data.map((e) => WordPron.fromMap(e)).toList();
    } else {
      this.pronounceUs = [];
    }

    if (pronounceUk != null) {
      List<dynamic> data = jsonDecode(pronounceUk);
      this.pronounceUk = data.map((e) => WordPron.fromMap(e)).toList();
    } else {
      this.pronounceUk = [];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'pron_uk': jsonEncode(pronounceUk.map((e) => e.toMap()).toList()),
      'pron_us': jsonEncode(pronounceUs.map((e) => e.toMap()).toList()),
      'captions': jsonEncode(captions?.map((e) => e.toMap()).toList() ?? []),
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

class WordPron {
  String pron;
  String? mp3;

  WordPron({
    required this.pron,
    required this.mp3,
  });

  Map<String, dynamic> toMap() {
    return {
      'pron': pron,
      'mp3': mp3,
    };
  }

  factory WordPron.fromMap(Map<String, dynamic> map) {
    return WordPron(
      pron: map['pron'] as String,
      mp3: map['mp3'] as String?,
    );
  }
}
