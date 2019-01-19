// Created by Tau on 2019/1/11
import 'package:uestc/data/course.dart';
import 'package:flutter/material.dart';
import 'package:uestc/theme.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard(this.course);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: course == null
          ? SizedBox()
          : Container(
              padding: EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildTitleText(),
                  buildIconText(Icons.location_on, course.room),
                  buildIconText(Icons.person, course.teacher),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[500], width: 1.2),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
    );
  }

  Container buildIconText(IconData icon, String s) {
    return Container(
//      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            size: 12,
            color: Colors.black54,
          ),
          Text(
            s,
            style: TextStyles.CardInfo,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Container buildTitleText() {
    return Container(
      child: Text(
        course.name,
        style: TextStyles.CardTile,
        maxLines: 2,
      ),
    );
  }
}
