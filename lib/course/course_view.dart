// Created by Tau on 2019/1/11
import 'package:flutter/material.dart';
import 'package:uestc/data/course.dart';
import 'course_widgets.dart';

//class CourseView extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return CourseTable();
//  }
//}

class CourseView extends StatefulWidget {
  @override
  State createState() => CourseViewState();
}

class CourseViewState extends State<CourseView> {
  Future<List<List<Course>>> _courses;

  CourseViewState() {
    _courses = fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return _tableBuilder();
  }

  FutureBuilder<List<List<Course>>> _tableBuilder() {
    return FutureBuilder<List<List<Course>>>(
      future: _courses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildTable(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black87,
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
          ),
        );
      },
    );
  }

  GridView _buildTable(List<List<Course>> courses) {
    return GridView.count(
      padding: EdgeInsets.all(4.0),
      crossAxisCount: 5,
//      maxCrossAxisExtent: 150,
      scrollDirection: Axis.horizontal,
      children:
          courses.reduce((a, b) => a + b).map((c) => CourseCard(c)).toList(),//TODO :if a or b is null
    );
  }
}
