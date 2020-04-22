import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final _httpClient = http.Client();
  final String apiUrl = "http://dev.amusetravel.com";


  Future<dynamic> get(String url) async {
    String accessToken = await getAccessToken();

    if (accessToken != null) {
      print("]-----] apiUrl + url [-----[ ${apiUrl + url}");
      final response = await _httpClient.get(apiUrl + url, headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        "Authorization": accessToken
      });
      print("]-----] get:response [-----[ ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 500) {
        if (response.body != null) {
          return json.decode(utf8.decode(response.bodyBytes));
        } else {
          return null;
        }
      } else if (response.statusCode == 401) {
        print("]-----] get:status code = 401 [-----[");
      } else if (response.statusCode == 404) {
        print("]-----] get:status code = 404 [-----[");
      } else {
        throw Exception('Error fetching get');
      }
    } else {
      print("]-----] get:status code = unknown [-----[");
    }
  }

  Future<dynamic> post(String url, String body) async {
    String accessToken = await getAccessToken();

    print("]----] accessToken[------[ $accessToken ");

    if (accessToken != null) {
      final response = await _httpClient.post(apiUrl + url,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": accessToken
          },
          body: body);

      print("]-----] post:response [-----[ ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 500) {
        return json.decode(utf8.decode(response.bodyBytes));
      } else if (response.statusCode == 401) {
        print("]-----] post:status code = 401 [-----[");
      } else {
        throw Exception('Error : id');
      }
    } else {
      print("]----] accessToken is null[------[");
    }
  }


  Future<dynamic> postWithoutAuth(String url, String body) async {
    print(']-------] postWithoutAuth : body [-------[ ${apiUrl + url}');
    final response = await _httpClient.post(apiUrl + url,
        headers: {'Content-Type': 'application/json'}, body: body);

    Map<String, dynamic> jsonBody =
    json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200 || response.statusCode == 500) {
      await persistToken(jsonBody['accessToken']);
      return jsonBody;
    } else {
      throw Exception('Error postWithoutAuth');
    }
  }

  Future<String> authenticate({
    @required String username,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("accessTokenWith");
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('accessTokenWith', token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessTokenWith');
    if (accessToken != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessTokenWith');
    return accessToken;
  }

  Future<String> getAuthenticate() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('usernameWith');
    return username;
  }

  Future<void> persistUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('usernameWith', username);
    return;
  }


  Future<void> persistEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('emailWith', email);
    return;
  }

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('emailWith');
    return email;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("accessTokenWith");
    prefs.remove('usernameWith');
  }

  Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessTokenWith');
    if (accessToken != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('usernameWith');
    return username;
  }


}
