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
