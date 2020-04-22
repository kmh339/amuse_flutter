import 'dart:async';
import 'dart:convert';
import 'package:amuse_flutter/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final http.Client _httpClient;

  final String apiUrl = "http://dev.amusetravel.com";

  AuthenticationBloc({
    @required UserRepository userRepository,
    @required http.Client httpClient,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        assert(httpClient != null),
        _httpClient = httpClient;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    await Future.delayed(Duration(seconds: 2));
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _userRepository.getUser();
        yield Authenticated(name);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getUser());
  }


  Future<dynamic> get(String url) async {
    String accessToken = await _userRepository.getAccessToken();

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
        this.add(LoggedOut());
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Error fetching get');
      }
    } else {
      this.add(LoggedOut());
    }
  }


  Future<dynamic> postWithoutAuth(String url, String body) async {
    print(']-------] postWithoutAuth : body [-------[ ${apiUrl + url}');
    final response = await _httpClient.post(apiUrl + url,
        headers: {'Content-Type': 'application/json'}, body: body);

    Map<String, dynamic> jsonBody =
        json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200 || response.statusCode == 500) {
      await _userRepository.persistToken(jsonBody['accessToken']);
      return jsonBody;
    } else {
      throw Exception('Error postWithoutAuth');
    }
  }

  Future<dynamic> snsAuth(String url, String body) async {
    print(']-------] snsAuth body [-------[ ${body}');
    final response = await _httpClient.post(apiUrl + url,
        headers: {'Content-Type': 'application/json'}, body: body);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        await _userRepository.persistToken(data["accessToken"]);
        return data["accessToken"].toString();
      } else {
        throw Exception('Error snsAuth');
      }
    } catch (error) {
      print("snsAuth error ==] ${error}");
      throw Exception('Error catch snsAuth');
    }
  }
}
