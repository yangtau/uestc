import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'login_contract.dart';
import 'login_presenter.dart';
import 'package:uestc/theme.dart';

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

class LoginViewState extends State<LoginView> implements View {
  var _isLoading = false;
  var _inputEnabled = true;
  var _isLogged = true;
  Presenter _presenter;

  final _passwordController = TextEditingController();
  final _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // BuildContext _context;

  @override
  void dispose() {
    _passwordController.dispose();
    _idController.dispose();
    _presenter.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _context = context;
    setPresenter(LoginPresenter(this));
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
          padding:
              const EdgeInsets.only(left: normalPadding, right: normalPadding),
          child: Center(
            child: _isLogged
                ? _buildWelcome()
                : ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(normalPadding),
                        child: _buildForm(),
                        height: buttonHeight * 3 + normalPadding * 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100.withOpacity(0.4),
                          borderRadius:
                              BorderRadius.circular(normalBorderRadius),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
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
                ),
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
                  enabled: _inputEnabled,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(normalPadding),
            child: _isLoading
                ? CircularProgressIndicator()
                : OutlineButton(
                    onPressed: _onPress,
                    child: new Text("LOGIN"),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    highlightedBorderColor: Theme.of(context).primaryColor,
                  ),
          ),
        ],
      ),
    );
  }

  _onPress() {
    _presenter.login(_idController.text, _passwordController.text);
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
      _inputEnabled = true;
    });
  }

  @override
  Future<void> setPresenter(Presenter presenter) async {
    _presenter = presenter;
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //  await Future.delayed(Duration(milliseconds: 10), () =>_presenter.subscribe());
    await _presenter.subscribe();
  }

  @override
  void showError(String msg) {
    _passwordController.clear();
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
      _inputEnabled = false;
    });
  }

  @override
  void toHomePage() {
    Navigator.of(_scaffoldKey.currentContext).pushReplacementNamed('/home');
  }

  @override
  void showLoginView() {
    setState(() {
      _isLogged = false;
    });
  }

  @override
  void showWelcomeView() {
    setState(() {
      _isLogged = true;
    });
  }
}
