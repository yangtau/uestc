// Created by Tau on 2019/1/15
import 'package:flutter/material.dart';
import 'grade_widgets.dart';
import 'package:uestc/theme.dart';
import 'package:uestc/data/grade.dart';
import 'package:uestc/custom_view.dart';

class GradeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GradeViewState();
}

class GradeViewState extends State<GradeView> {
  Future<List<Grade>> _gradeFuture;
  bool _isExpanded = false;

  GradeViewState() {
    _gradeFuture = fetchGradeBySemester();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Grade>>(
      future: _gradeFuture,
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
      child: BoxExpansionTile(
        titleHeight: 60,
        title: Container(
          child: Text('helo'),
        ),
        children: <Widget>[
          Container(
            height: 66,
            child: Text('helo'),
          ),
          Container(
            height: 66,
            child: Text('helo'),
          ),
        ],
        initiallyExpanded: _isExpanded,
      ),
    );
  }
}
