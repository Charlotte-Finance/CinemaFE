class Movie {
  final int? id;
  final String title;
  final int duration;
  final DateTime release;
  final int budget;
  final int revenue;
  final int directorId;
  final String categoryCode;

  Movie({
    this.id,
    required this.title,
    required this.duration,
    required this.release,
    required this.budget,
    required this.revenue,
    required this.directorId,
    required this.categoryCode,
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
