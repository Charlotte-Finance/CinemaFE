class Category {
  String code;
  String label;
  String picture;


  Category({
    required this.code,
    required this.label,
    required this.picture,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      code: json['code'],
      label: json['label'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['label'] = label;
    data['picture'] = picture;
    return data;
  }
}
