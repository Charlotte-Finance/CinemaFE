class Actor {
  final int? id;
  final String name;
  final String firstname;
  final DateTime birth;
  final DateTime? death;

  Actor({
    this.id,
    required this.name,
    required this.firstname,
    required this.birth,
    required this.death,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      firstname: json['firstname'],
      birth: json['birth'],
      death: json['death'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['firstname'] = firstname;
    data['birth'] = birth;
    data['death'] = death;
    return data;
  }
}
