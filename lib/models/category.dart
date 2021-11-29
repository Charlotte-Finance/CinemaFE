class Category {
  final String code;
  final String label;


  Category({
    required this.code,
    required this.label,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      code: json['code'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['label'] = label;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          label == other.label;

  @override
  int get hashCode => label.hashCode;
}
