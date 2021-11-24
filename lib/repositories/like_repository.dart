import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';

class LikeRepository {
  final String url = "/likes/";

  Future<bool> getLike(User user, Movie movie) async {
    Map<String, dynamic> parameters = {
      'userId': user.id.toString(),
      'movieId': movie.id.toString()
    };

    final bool = await HttpRequest.getRequest(
        parameters: parameters, endpoint: url + "is_liked");
    return bool;
  }

  Future<bool> changeLike(User user, Movie movie) async {
    Map<String, dynamic> parameters = {
      'userId': user.id.toString(),
      'movieId': movie.id.toString()
    };
    final bool = await HttpRequest.getRequest(
        parameters: parameters, endpoint: url + "change-like");
    return bool;
  }
}
