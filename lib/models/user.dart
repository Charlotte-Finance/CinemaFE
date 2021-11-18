class User {
  int id;
  String username;
  String password;
  String role;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
