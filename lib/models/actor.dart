import 'character.dart';

class Actor {
  int? id;
  String? name;
  String? firstname;
  String? birth;
  String? death;

  List<Character>? characters;

  Actor({
    this.id,
    this.name,
    this.firstname,
    this.birth,
    this.death,
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
