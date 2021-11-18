import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';
import 'package:http/http.dart' as http;

class LikeRepository {
  final String url = "/likes/";

  Future<bool> getLike(Movie movie) async {
    User user;
    final movies = await HttpRequest.getRequest(endpoint: url);
    if ((movies as List)
        .map((movie) => Movie.fromJson(movie))
        .toList()
        .isEmpty) {
      return false;
    }
    return true;
  }
}
