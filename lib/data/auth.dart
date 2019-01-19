// Created by Tau on 2018/12/30
import 'package:shared_preferences/shared_preferences.dart';
import 'net.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

// a model used to login...
class LoginMsg {
  final String id, password;

  LoginMsg(this.id, this.password);

  Map getJson() => {'username': id, 'password': password};
}

typedef isLoggedCallback = void Function(bool isLogged);

class AuthManager {
  static const _idKey = 'id_key'; //string
  static const _passwordKey = 'password_key'; //string
  static String _token;
  static SharedPreferences _prefs;
  static String _id, _password;

  AuthManager._internal();

  static _init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
      _token = '';
      _id = _prefs.getString(_idKey) ?? '';
      _password = _prefs.getString(_passwordKey) ?? '';
    }
  }

  static Future<bool> isLogged() async {
    if (_prefs == null) await _init();
    return _id.isNotEmpty && _password.isNotEmpty;
  }

  /// call only if isLogged return true
  static Future<String> fetchToken({bool update = false}) async {
    if (_prefs == null) await _init();
    if (_token.isNotEmpty && !update) return _token;
    if (_id.isEmpty || _password.isEmpty)
      throw Exception('id or password is empty');
    try {
      final response = await http.post(API.loginUrl,
          body: LoginMsg(_id, _password).getJson());
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body['code'] == 201) _token = body['data']['token'];
      }
    } on SocketException catch (_) {}
    return _token;
  }

  ///save login msg and token to local disk
  static Future<void> login(
      LoginMsg loginMsg, Callback<String> tokenCallback) async {
    tokenCallback.onStart();
    if (_prefs == null) await _init();
    try {
      final response = await http.post(API.loginUrl, body: loginMsg.getJson());
      if (response.statusCode != 200) {
        tokenCallback.onFailed(NetworkCode);
      } else {
        var body = json.decode(response.body);
        if (body['code'] == 201) {
          _token = body['data']['token'];
          // _prefs.setString(_tokenKey, _token);
          _prefs.setString(_idKey, loginMsg.id);
          _prefs.setString(_passwordKey, loginMsg.password);
          // _prefs.setInt(_updateKey, DateTime.now().millisecondsSinceEpoch);
          tokenCallback.onSuccess(_token);
        } else {
          tokenCallback.onFailed(body['code'] ?? NoIdeaCode);
        }
      }
    } on SocketException catch (_) {
      tokenCallback.onFailed(NetworkCode);
    } finally {
      tokenCallback.onFinish();
    }
  }
}
