import 'package:uestc/mvp.dart';

abstract class Presenter implements IPresenter {
  Future<void> login(String id, String password);
}

abstract class View implements IView<Presenter> {
  void showLoading();

  void hideLoading();

  void toHomePage();

  void showError(String msg);

  void showWelcomeView();

  void showLoginView();
}
