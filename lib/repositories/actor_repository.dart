import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/utils/http_request.dart';

class ActorRepository {
  final String url = "/actors/";

  Future<List<Actor>> getActors() async {
    final actors = await HttpRequest.getRequest(endpoint: url);
    return (actors as List).map((actor) => Actor.fromJson(actor)).toList();
  }

  Future<Actor> getActor(int id) async {
    final actor = await HttpRequest.getRequest(endpoint: url + "$id/");
    return Actor.fromJson(actor);
  }
}
