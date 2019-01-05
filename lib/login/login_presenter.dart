import 'login_contract.dart';
import 'package:uestc/data/auth.dart';
import 'package:uestc/data/network_callback.dart';

class LoginPresenter implements Presenter, Callback<String> {
  AuthManager _authManager;
  final View _view;

  LoginPresenter(this._view) {
    _view.setPresenter(this);
  }

  @override
  Future<void> subscribe() async {
    _authManager = await AuthManager.getInstance();
    // final isLogged = await _authManager.isLogged();
    if (await _authManager.isLogged()) {
      _authManager.fetchToken().then((_) {
        _view.toHomePage();
      });
    } else
      _view.showLoginView();
  }

  @override
  Future<void> login(String id, String password) async {
    await _authManager.login(LoginMsg(id, password), this);
  }

  @override
  Future<void> unsubscribe() async {}

  @override
  void onFailed(int code) {
    switch (code) {
      case NetworkCode:
        _view.showError(
            'Check the network, or there is something wrong with the server');
        break;
      case ValidationCode:
        _view.showError('Invalid ID or password.');
        break;
      case PasswordCode:
        _view.showError('Wrong ID or password.');
        break;
      default:
        _view.showError('I don\'t know what\'s going wrong:(.');
        break;
    }
  }

  @override
  void onStart() {
    _view.showLoading();
  }

  @override
  void onSuccess(String t) {
    if ((t ?? '').isNotEmpty) _view.toHomePage();
  }

  @override
  void onFinish() {
    _view.hideLoading();
  }
}
