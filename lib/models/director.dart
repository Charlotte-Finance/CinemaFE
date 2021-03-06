class Director {
  int? id;
  String? name;
  String? firstname;

  Director({
    this.id,
    this.name,
    this.firstname,
  });

  factory Director.fromJson(Map<String, dynamic> json) {
    return Director(
      id: json['id'],
      name: json['name'],
      firstname: json['firstname'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['firstname'] = firstname;
    return data;
  }
}
