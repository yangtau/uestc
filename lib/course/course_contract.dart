// Created by Tau on 2019/1/11
import 'package:uestc/mvp.dart';
import 'package:uestc/data/course.dart';

abstract class Presenter implements IPresenter {
  void refresh();
}

abstract class View implements IView<Presenter> {
  void showRefreshing();

  void showCourseTable(List<List<Course>> courses);
}
