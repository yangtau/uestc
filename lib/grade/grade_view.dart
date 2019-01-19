// Created by Tau on 2019/1/15
import 'package:flutter/material.dart';
import 'grade_widgets.dart';
import 'package:uestc/theme.dart';
import 'package:uestc/data/grade.dart';
import 'package:uestc/custom_view.dart';
import 'package:uestc/data/date.dart';

class GradeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GradeViewState();
}

class GradeViewState extends State<GradeView> {
//  Future<List<Grade>> _gradeFuture;
  bool _isExpanded = false;
  Future<List<Semester>> _semestersFuture;
  Semester _semester;

  GradeViewState() {
    _semester = Semester.now;
    _semestersFuture = fetchSemesters();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Grade>>(
      future: fetchGradeBySemester(semester: _semester),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            padding: const EdgeInsets.all(4.0),
            children: <Widget>[_buildExpansion(context)] +
                snapshot.data.map((g) => GradeCard(g)).toList(),
          );
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

  _buildExpansion(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FutureBuilder<List<Semester>>(
          future: _semestersFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return BoxExpansionTile(
                titleHeight: 60,
                title: Container(
                  child: Text(_semester.toString()),
                ),
                children: snapshot.data
                    .map((s) => Container(
                          height: 60,
                          child: ListTile(
                            title: Text(s.toString()),
                            onTap: () {
                              setState(() {
                                _semester = s;
                              });
                            },
                          ),
                        ))
                    .toList(),
                initiallyExpanded: _isExpanded,
              );
            else
              return BoxExpansionTile(
                titleHeight: 60,
                title: Container(
                  child: Text(_semester.toString()),
                ),
              );
          },
        ));
  }
}
