import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  //static const String _address = "10.0.2.2"; // Emulator
  static const String _address = "127.0.0.1"; // Web
  static const int _port = 8080;

  static Future<dynamic> getEntireRequest(
      {Map<String, dynamic>? parameters, required String endpoint}) async {
    Uri httpRequest = Uri.parse(endpoint);
    final response = await http.get(
      httpRequest,
      headers: <String, String>{
        'connection': 'Keep-Alive',
      },
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body.toString()));
    } else {
      throw Exception('Failed');
    }
  }

  static Future<dynamic> getRequest(
      {Map<String, dynamic>? parameters, required String endpoint}) async {
    Uri httpRequest = Uri(
      path: endpoint,
      port: _port,
      host: _address,
      queryParameters: parameters,
    );
    print(httpRequest.toString());
    final response = await http.get(
      httpRequest,
    );
    print("AAAAAAAAAAAAAAAAAAAAAAAA");
    if (response.statusCode == 200) {
      return (json.decode(response.body.toString()));
    } else {
      throw Exception('Failed');
    }
  }

  static Future<dynamic> postRequest(String endpoint, String jsonBody) async {
    Uri httpRequest = Uri(path: endpoint, port: _port, host: _address);
    final response = await http.post(
      httpRequest,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed');
    } else {
      return json.decode(response.body.toString());
    }
  }

  static Future<dynamic> putRequest(String endpoint, String jsonBody) async {
    Uri httpRequest = Uri(path: endpoint, port: _port, host: _address);
    final response = await http.put(
      httpRequest,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed');
    } else {
      return json.decode(response.body.toString());
    }
  }
}
