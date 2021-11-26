import 'dart:convert';

import 'package:cinema_fe/models/character.dart';
import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/utils/http_request.dart';

class CharacterRepository {
  final String url = "/characters/";

  Future<List<Character>> getCharacters() async {
    final characters = await HttpRequest.getRequest(endpoint: url);
    return (characters as List)
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<Character> getCharacter(int id) async {
    final character = await HttpRequest.getRequest(endpoint: url + "$id/");
    return Character.fromJson(character);
  }

  Future<List<Character>> getByMovie(Movie movie) async {
    final Map<String, String> _queryParameters = <String, String>{
      'movieId': movie.id.toString()
    };
    final characters = await HttpRequest.getRequest(
        parameters: _queryParameters, endpoint: url + "by-movie/");
    return (characters as List).map((p) => Character.fromJson(p)).toList();
  }

  Future<void> post(Character character) async {
    final String json = jsonEncode(character);
    await HttpRequest.postRequest(url, json);
  }


  Future<Character> delete(Character character) async {
    final String json = jsonEncode(character);
    final response = await HttpRequest.deleteRequest(url, json);
    return Character.fromJson(response);
  }
}
