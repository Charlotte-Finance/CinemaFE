import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/utils/http_request.dart';

class CategoryRepository {
  final String url = "/categories/";

  Future<List<Category>> getCategories() async {
    final categories = await HttpRequest.getRequest(endpoint: url);
    return (categories as List)
        .map((actor) => Category.fromJson(actor))
        .toList();
  }

  Future<Category> getCategory(String code) async {
    final actor = await HttpRequest.getRequest(endpoint: url + "$code/");
    return Category.fromJson(actor);
  }
}
