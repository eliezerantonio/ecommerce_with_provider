import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final _url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDO9FOhXzYndsm0cWEOZeIsLYdFsaa5RAQ';

    final response = await http.post(
      _url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    print(json.decode(response.body));
    return Future.value();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}