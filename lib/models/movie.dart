import 'actor.dart';
import 'category.dart';
import 'character.dart';
import 'director.dart';

class Movie {
  int? id;
  String? title;
  int? duration;
  DateTime? release;
  int? budget;
  int? revenue;
  int? directorId;
  String? categoryCode;
  Director? director;
  Category? category;
  bool? isLiked = false;
  List<Actor>? actors;
  List<Character>? characters;

  Movie({
    this.id,
    this.title,
    this.duration,
    this.release,
    this.budget,
    this.revenue,
    this.directorId,
    this.categoryCode,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      release: json['release'],
      budget: json['budget'],
      revenue: json['revenue'],
      directorId: json['director_id'],
      categoryCode: json['category_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['duration'] = duration;
    data['release'] = release;
    data['budget'] = budget;
    data['revenue'] = revenue;
    data['director_id'] = directorId;
    data['category_code'] = categoryCode;
    return data;
  }
}
