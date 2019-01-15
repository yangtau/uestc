import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:uestc/theme.dart';
import 'package:uestc/data/auth.dart';
import 'package:uestc/data/net.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> implements Callback<String> {
  var _isLoading = false;
  var _inputEnabled = true;
  bool _isLogged = true;

  final _passwordController = TextEditingController();
  final _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _isLogged = await AuthManager.isLogged();
    if (_isLogged) {
      AuthManager.fetchToken().then((s) => toHomePage());
    } else
      setState(() {
        _isLogged = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/uestc-10.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: _isLogged ? _buildWelcome() : _buildLoginView(),
          ),
        ),
      ),
    );
  }

  _onPress() {
    AuthManager.login(
        LoginMsg(_idController.text, _passwordController.text), this);
  }

  void hideLoading() {
    setState(() {
      _isLoading = false;
      _inputEnabled = true;
    });
  }

  void showError(String msg) {
    _passwordController.clear();
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void showLoading() {
    setState(() {
      _isLoading = true;
      _inputEnabled = false;
    });
  }

  void toHomePage() {
    Navigator.of(_scaffoldKey.currentContext).pushReplacementNamed('/home');
  }

  Widget _buildLoginView() {
    return Container(
      padding: EdgeInsets.all(normalPadding),
      child: _buildForm(),
      height: buttonHeight * 3 + normalPadding * 8,
      decoration: BoxDecoration(
        color: Colors.grey.shade100.withOpacity(0.85),
        borderRadius: BorderRadius.circular(normalBorderRadius),
      ),
    );
  }

  Widget _buildWelcome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 200,
        ),
        const Text(
          'UESTC',
          style: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Viga',
            fontSize: 70,
            letterSpacing: 8,
          ),
        ),
      ],
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(normalPadding),
            child: Container(
              height: buttonHeight,
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(
                    labelText: 'Student ID',
                    labelStyle: TextStyle(color: Colors.black87)),
                enabled: _inputEnabled,
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(normalPadding),
            child: Container(
              height: buttonHeight,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black87)),
                enabled: _inputEnabled,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(normalPadding),
            child: _isLoading
                ? CircularProgressIndicator(
                backgroundColor: Colors.black87,
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
            )
                : OutlineButton(
              onPressed: _onPress,
              child: new Text("LOGIN"),
              borderSide: BorderSide(
                color: Colors.black87,
              ),
              highlightedBorderColor: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onFailed(int errorCode) {
    switch (errorCode) {
      case NetworkCode:
        showError(
            'Check the network, or there is something wrong with the server');
        break;
      case ValidationCode:
        showError('Invalid ID or password.');
        break;
      case PasswordCode:
        showError('Wrong ID or password.');
        break;
      default:
        showError('I don\'t know what\'s going wrong:(.');
        break;
    }
  }

  @override
  void onFinish() {
    hideLoading();
  }

  @override
  void onStart() {
    showLoading();
  }

  @override
  void onSuccess(String t) {
    if ((t ?? '').isNotEmpty) toHomePage();
  }
}
