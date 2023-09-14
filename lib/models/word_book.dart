class WordBook {
  int id;
  int useId;
  int type;
  String name;
  String description;
  String createdAt;

  WordBook({
    required this.id,
    required this.useId,
    required this.type,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': useId,
      'type': type,
      'name': name,
      'description': description,
      'created_at': createdAt,
    };
  }

  factory WordBook.fromMap(Map<String, dynamic> map) {
    return WordBook(
      id: map['id'] as int,
      useId: map['user_id'] as int,
      type: map['type'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      createdAt: map['created_at'] as String,
    );
  }
}
