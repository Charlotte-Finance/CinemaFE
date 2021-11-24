import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';

class UserRepository {
  final String url = "/users/";

  Future<User> login(String username, String password) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    final String json = data.toString();
    final user = await HttpRequest.postRequest(url+"login/", json);
    return User.fromJson(user);
  }
}
