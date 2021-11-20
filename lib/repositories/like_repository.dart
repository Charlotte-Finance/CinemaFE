import 'package:cinema_fe/models/movie.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';
import 'package:http/http.dart' as http;

class LikeRepository {
  final String url = "/likes/";

  Future<bool> getLike(User user, Movie movie) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user.id;
    data['movie_id'] = movie.id;
    final String json = data.toString();
    final bool = await HttpRequest.postRequest(url+"is-liked/", json);
    return bool;
  }

  Future<bool> changeLike(User user, Movie movie) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_liked'] = user.id;
    data['movie_id'] = movie.id;
    final String json = data.toString();
    final bool = await HttpRequest.postRequest(url+"change-like/", json);
    return bool;
  }

}
