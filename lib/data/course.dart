// Created by Tau on 2019/01/01
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'net.dart';
import 'auth.dart';

class Course {
  final String name, id, teacher, room;
  Map<int, int> _time; //key 1~7, value 1~5
  Map<int, int> get time => _time;

  Course.fromJson(Map data)
      : name = data['courseName'],
        id = data['courseId'],
        teacher = data['teacher'],
        room = data['room'];

  @override
  String toString() {
    return '{name: $name, id: $id, teacher: $teacher, room: $room, time: $time}';
  }

  @override
  bool operator ==(other) {
    return id == other.id;
  }
}

Future<List<List<Course>>> fetchCourses() async {
  var courses = List<List<Course>>(7);
  for (int i = 0; i < 7; i++) courses[i] = List<Course>(5);
  final token = await AuthManager.fetchToken();
  if (token.isEmpty) {
    return courses;
  }
  var header = {
    'Authorization': 'Bearer ' + token,
  };
  var postBody = {'year': '2018', 'semester': '2'};
//  TODO: add data
  try {
    var response =
        await http.post(API.courseUrl, headers: header, body: postBody);
    if (response.statusCode != 200) {
//      courseCallback.onFailed(NetworkCode);
    } else {
      final body = json.decode(response.body);
      print(body);
      if (body['code'] != 201) {
//          courseCallback.onFailed(NetworkCode);
        if (body['code'] == 403) {
          //todo
        }
      } else {
        for (var data in body['data']) {
          var time = data['time'];
          for (var tmp in time) {
            int section;
            final t = int.parse(tmp[1]);
            if (t < 2) {
              section = 0;
            } else if (t < 4) {
              section = 1;
            } else if (t < 6) {
              section = 2;
            } else if (t < 8) {
              section = 3;
            } else {
              section = 4;
            }
            courses[int.parse(tmp[0])][section] = Course.fromJson(data);
          }
        }
      }
    }
  } on SocketException catch (_) {} finally {
//    courseCallback.onFinish();
  }
  print(courses);
  return courses;
}
