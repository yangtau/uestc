// Created by Tau on 2019/1/1
abstract class Callback<T> {
  void onStart();

  void onFailed(int errorCode);

  void onSuccess(T t);

  void onFinish();
}

// Created by Tau on 2018/12/31
class API {
  static const loginUrl = 'https://uestc.ga/api/user/login'; //post
  static const profileUrl = 'https://uestc.ga/api/user/profile'; //get
  static const courseUrl = 'https://uestc.ga/api/user/course'; //post
  static const gradeUrl = 'https://uestc.ga/api/user/grade'; //post and get
}

const NoIdeaCode = -2; //:)
const NetworkCode = -1;
const PasswordCode = 403;
const ValidationCode = 422;
const NoTokenCode = 1;

class DateHeader {
  final year;
  final semester;

  DateHeader(this.year, this.semester);

  Map getJson() => {'year': year, 'semester': semester};
}
