import 'package:app_flutter/features/auth/domain/entity/user.dart';

class UserModel{
  String? id;
  String name;
  String lastname;
  String email;
  String phone;
  String password;
  String? sessionToken;

  UserModel({
    this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.password,
    this.sessionToken
  });

  factory UserModel.fromJson(Map<String,dynamic> json) =>
    UserModel(
      id: json["id"],
      name: json["name"],
      lastname: json["lastname"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
      sessionToken: json["session_token"]
    );

  Map<String,dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "password": password,
    "session_token": sessionToken
  };

  User toEntity() => User(
      id: id,
      name: name,
      lastname: lastname,
      email: email,
      phone: phone,
      password: password,
      sessionToken: sessionToken
    );
}