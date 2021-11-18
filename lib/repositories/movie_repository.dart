import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  final String url = "/movies/";

  Future<List<Movie>> getMovies() async {
    final movies = await HttpRequest.getRequest(endpoint: url);
    return (movies as List).map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<Movie> getMovie(int id) async {
    final movie = await HttpRequest.getRequest(endpoint: url + "$id/");
    return Movie.fromJson(movie);
  }

  Future<List<Movie>> getFavouriteMovies() async {
    User user;
    final movies = await HttpRequest.getRequest(endpoint: url+"user/");
    return (movies as List).map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<Movie> like(Movie movie) async {
    final movie = await HttpRequest.getRequest(endpoint: url + "like/");
    return Movie.fromJson(movie);
  }


}
