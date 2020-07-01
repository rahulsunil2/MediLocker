class NewUser {
  final String username;
  // ignore: non_constant_identifier_names
  final String first_name;
  // ignore: non_constant_identifier_names
  final String last_name;
  final String email;
  final String password;

  // ignore: non_constant_identifier_names
  NewUser({
    this.username,
    this.first_name,
    this.last_name,
    this.email,
    this.password,
  });

  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
      username: json['username'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["first_name"] = first_name;
    map["last_name"] = last_name;
    map["email"] = email;
    map["password"] = password;

    return map;
  }
}
