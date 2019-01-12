// Created by Tau on 2019/1/11
import 'package:flutter/material.dart';
import 'course_contract.dart';
import 'package:uestc/data/course.dart';
import 'widgets.dart';
import 'course_presenter.dart';

class CourseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('course'),),
      body: CourseTable(),
    );
  }
}

class CourseTable extends StatefulWidget {
  @override
  State createState() => CourseTableState();
}

class CourseTableState extends State<CourseTable> implements View {
  Presenter _presenter;
  bool _showCourses = false;
  List<List<Course>> _courses;

  @override
  Widget build(BuildContext context) {
    if (_presenter == null) setPresenter(CoursePresenter(this));
    return _showCourses
        ? _buildTable(_courses)
        : Center(
            child: Text('hello'),
          );
  }

  @override
  void dispose() {
    _presenter.unsubscribe();
    super.dispose();
  }

  Widget _buildTable(List<List<Course>> courses) {
    var tableColumns = List<Column>(7);
    for (int i = 0; i < 7; i++) {
      var cards = List<Widget>(5);
      for (int j = 0; j < 5; j++) {
        if (courses[i][j] != null)
          cards[j] = CourseCard(courses[i][j]);
        else
          cards[j] = SizedBox(
            width: 120,
            height: 120,
          );
      }
      tableColumns[i] = Column(
        children: cards,
      );
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: tableColumns,
    );
  }

  @override
  Future<void> setPresenter(Presenter presenter) async {
    _presenter = presenter;
    await _presenter.subscribe();
  }

  @override
  void showRefreshing() {}

  @override
  void showCourseTable(List<List<Course>> courses) {
    _courses = courses;
    setState(() {
      _showCourses = true;
    });
  }
}
