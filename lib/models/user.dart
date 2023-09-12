import '../common/local.dart';

class User implements MappableData {
  int id;
  String? name;
  String nickName;
  String phone;
  String? email;
  String password;
  DateTime createdAt;

  User({
    required this.id,
    this.name,
    required this.nickName,
    required this.phone,
    this.email,
    required this.password,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nick_name': nickName,
      'phone': phone,
      'email': email,
      'password': password,
      'created_at': createdAt.toString(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      nickName: map['nick_name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
