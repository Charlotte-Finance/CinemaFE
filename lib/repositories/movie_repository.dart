import 'dart:convert';

import 'package:cinema_fe/models/category.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';

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

  Future<List<Movie>> getMoviesByCategory(Category category) async {
    final movies = await HttpRequest.getRequest(
        endpoint: url + "category/${category.code}");
    return (movies as List).map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<List<Movie>> getLikedMovies(User user) async {
    final movies =
        await HttpRequest.getRequest(endpoint: url + "liked/${user.id}");
    return (movies as List).map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<Movie> post(Movie movie) async {
    final String json = jsonEncode(movie);
    final response = await HttpRequest.postRequest(url, json);
    return Movie.fromJson(response);
  }

  Future<Movie> put(Movie movie) async {
    final String json = jsonEncode(movie);
    final response = await HttpRequest.putRequest(url, json);
    return Movie.fromJson(response);
  }


  Future<Movie> delete(Movie movie) async {
    final String json = jsonEncode(movie);
    final response = await HttpRequest.deleteRequest(url, json);
    return Movie.fromJson(response);
  }
}
