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
