class Character {
  int actorId;
  int movieId;
  String name;

  Character({
    required this.actorId,
    required this.movieId,
    required this.name,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      actorId: json['key']['actorId'],
      movieId: json['key']['movieId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key']['actorId'] = actorId;
    data['key']['movieId'] = movieId;
    data['name'] = name;
    return data;
  }
}
