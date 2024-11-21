class User{
  String? id;
  String name;
  String lastname;
  String email;
  String phone;
  String password;
  String? sessionToken;

  User({
    this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.password,
    this.sessionToken
  });
}