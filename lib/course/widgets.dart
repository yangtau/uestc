// Created by Tau on 2019/1/11
import 'package:uestc/data/course.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Course _course;

  CourseCard(this._course);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              color: Colors.red,
              height: 40,
              width: 6,
            ),
          ),
          Container(
            width: 120,
            height: 120,
            padding: EdgeInsets.only(right: 8, top: 8, bottom: 8, left: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 104,
                  child: Text(
                    _course.name,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    maxLines: 2,
//                textDirection: TextDirection.ltr,
                  ),
                ),
                Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 12,
                      ),
                      Text(
                        _course.room,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 12,
                      ),
                      Text(
                        _course.teacher,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
