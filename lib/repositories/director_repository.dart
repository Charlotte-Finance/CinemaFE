import 'package:cinema_fe/models/director.dart';
import 'package:cinema_fe/utils/http_request.dart';

class DirectorRepository {
  final String url = "/directors/";

  Future<List<Director>> getDirectors() async {
    final directors = await HttpRequest.getRequest(endpoint: url);
    return (directors as List).map((director) => Director.fromJson(director)).toList();
  }

  Future<Director> getDirector(int id) async {
    final director = await HttpRequest.getRequest(endpoint: url + "$id/");
    return Director.fromJson(director);
  }
}
