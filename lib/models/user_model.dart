import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String name;
  final String email;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
  });

  User.fromJson(Map json)
    : id = json['id'],
      name = json['name'],
      email = json['email'];
}
