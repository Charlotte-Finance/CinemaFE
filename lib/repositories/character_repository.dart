import 'dart:convert';

import 'package:cinema_fe/models/character.dart';
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

  Future<Character> post(Character character) async {
    final String json = jsonEncode(character);
    final response = await HttpRequest.postRequest(url, json);
    return Character.fromJson(response);
  }
}
