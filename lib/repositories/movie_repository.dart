import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/utils/http_request.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  final String url = "/movies/";

  Future<List<Movie>> getMovies() async {
    final movies = await HttpRequest.getRequest(endpoint: url);
    print("BBBBB");

    return (movies as List).map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<Movie> getMovie(int id) async {
    final movie = await HttpRequest.getRequest(endpoint: url + "$id/");
    return Movie.fromJson(movie);
  }
}
