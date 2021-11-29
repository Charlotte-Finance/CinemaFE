import 'package:cinema_fe/models/user.dart';
import 'package:cinema_fe/utils/http_request.dart';

class UserRepository {
  final String url = "/users/";

  Future<User> login(User user) async {
    final Map<String, String> _queryParameters = <String, String>{
      'userId': user.username!,
      'password': user.password!
    };
    final response = await HttpRequest.getRequest(
        parameters: _queryParameters, endpoint: url + "login/");
    // ToDo : Remove this line
    return User(id:5, username: "Charlotte", password: "azerty", role: "admin");
    //return User.fromJson(response);
  }
}
