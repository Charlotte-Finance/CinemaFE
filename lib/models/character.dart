import 'actor.dart';
import 'movie.dart';

class Character {
  int? id;
  int? actorId;
  int? movieId;
  String? name;
  Actor? actor;
  Movie? movie;

  Character({
    this.id,
    this.actorId,
    this.movieId,
    this.name,
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
