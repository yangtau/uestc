// Created by Tau on 2018/12/30
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'network_callback.dart';
import 'dart:io';

const NoIdeaCode = -2; //:)
const NetworkCode = -1;
const PasswordCode = 403;
const ValidationCode = 422;

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
  String _token;
  SharedPreferences _prefs;
  String _id, _password;

  AuthManager._internal() {}
  _init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = '';
    _id = _tokenManager._prefs.getString(_idKey) ?? '';
    _password = _prefs.getString(_passwordKey) ?? '';
  }

  static AuthManager _tokenManager;

  static Future<AuthManager> getInstance() async {
    if (_tokenManager == null) {
      _tokenManager = AuthManager._internal();
      // await _tokenManager._init();
    }
    return _tokenManager;
  }

  Future<bool> isLogged() async {
    if (_prefs == null) await _init();
    return _id.isNotEmpty && _password.isNotEmpty;
  }

  /// call only if isLogged return true
  Future<String> fetchToken() async {
    if (_prefs == null) await _init();
    if (_token.isNotEmpty) return _token;
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
  Future<void> login(LoginMsg loginMsg, Callback<String> tokenCallback) async {
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
