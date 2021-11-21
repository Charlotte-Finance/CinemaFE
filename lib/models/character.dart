class Character {
  final int? id;
  final int actorId;
  final int movieId;
  final String name;

  Character({
    this.id,
    required this.actorId,
    required this.movieId,
    required this.name,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      actorId: json['actorId'],
      movieId: json['movieId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['actorId'] = actorId;
    data['movieId'] = movieId;
    data['name'] = name;
    return data;
  }
}
