import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
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

  Future<void> persistNotipicationToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('notipicationToken', token);
    return;
  }

  Future<String> getNotificationToken() async {
    final prefs = await SharedPreferences.getInstance();
    String notipicationToken = prefs.getString('notipicationToken');
    return notipicationToken;
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


  Future<int> getStartAt() async {
    final prefs = await SharedPreferences.getInstance();
    int startAt = prefs.getInt('startatWith');
    return startAt;
  }

  Future<void> persistStartAt(int startAt) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('startatWith', startAt);
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

  Future<void> persistAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('addressWith', address);
    return;
  }

  Future<void> persistDayDuration(int dayDuration) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('dayDurationWith', dayDuration);
    return;
  }

  Future<int> getDayDuration() async {
    final prefs = await SharedPreferences.getInstance();
    int dayDuration = prefs.getInt('dayDurationWith');
    return dayDuration;
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
