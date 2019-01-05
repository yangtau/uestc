// Created by Tau on 2019/1/1
abstract class Callback<T> {
  void onStart();
  void onFailed(int errorCode);
  void onSuccess(T t);
  void onFinish();
}
