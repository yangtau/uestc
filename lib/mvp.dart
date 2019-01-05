// Created by Tau on 2018/12/30

abstract class IView<T extends IPresenter> {
  Future<void> setPresenter(T presenter);
}

abstract class IPresenter {
  Future<void> subscribe();
  Future<void> unsubscribe();
}
