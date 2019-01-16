// Created by Tau on 2019/1/15
import 'package:uestc/data/grade.dart';
import 'package:flutter/material.dart';
import 'package:uestc/theme.dart';

class GradeCard extends StatelessWidget {
  final Grade grade;

  GradeCard(this.grade);

  @override
  Widget build(BuildContext context) {
    int t = grade.type.indexOf('（');
    final type = grade.type.substring(0, t == -1 ? grade.type.length : t);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 66,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500], width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  grade.name,
                  style: TextStyles.CardTile,
                  maxLines: 1,
                ),
                Text(
                  type,
                  style: TextStyles.HeaderInfo,
                  maxLines: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('credit: ${grade.credit}', style: TextStyles.HeaderInfo),
                Text('gpa: ${grade.gpa}', style: TextStyles.HeaderInfo),
                Text('final: ${grade.finalScore}', style: TextStyles.HeaderInfo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
