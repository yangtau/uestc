// Created by Tau on 2019/1/11
import 'course_contract.dart';
import 'package:uestc/data/net.dart';
import 'package:uestc/data/course.dart';

class CoursePresenter implements Presenter, Callback<List<List<Course>>> {
  final View _view;

  CoursePresenter(this._view);

  @override
  void refresh() {}

  @override
  Future<void> subscribe() async {
    fetchCourses(this);
  }

  @override
  Future<void> unsubscribe() {}

  @override
  void onFailed(int errorCode) {}

  @override
  void onFinish() {}

  @override
  void onStart() {}

  @override
  void onSuccess(List<List<Course>> t) {
    _view.showCourseTable(t);
  }
}
