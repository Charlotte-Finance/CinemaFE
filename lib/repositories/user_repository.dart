import 'package:cinema_fe/models/actor.dart';
import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';

class UserRepository {
  final String url = "/users/";

  Future<User> login(String email, String password) async {
    final user = await HttpRequest.getRequest(endpoint: url + "login/");
    return User.fromJson(user);
  }
}
