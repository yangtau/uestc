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

  Course.fromJson(Map json)
      : name = json['courseName'],
        id = json['courseId'],
        teacher = json['teacher'],
        room = json['room'] {}

  @override
  String toString() {
    return '{name: $name, id: $id, teacher: $teacher, room: $room, time: $time}';
  }

  @override
  bool operator ==(other) {
    return id == other.id;
  }
}

Future<void> fetchCourses(Callback<List<List<Course>>> courseCallback) async {
  courseCallback.onStart();
  final auth = await AuthManager.getInstance();
  final token = await auth.fetchToken();
  if (token.isEmpty) {
    courseCallback.onFailed(NoTokenCode);
    courseCallback.onFinish();
    return;
  }
  var header = {
    'Authorization': 'Bearer ' + token,
  };
  var postBody = {'year': '2018', 'semester': '2'};
  try {
    var response =
        await http.post(API.courseUrl, headers: header, body: postBody);
    if (response.statusCode != 200) {
      courseCallback.onFailed(NetworkCode);
    } else {
      final body = json.decode(response.body);
      if (body['code'] != 201)
        courseCallback.onFailed(NetworkCode);
      else {
        var courses = List<List<Course>>(7);
        for (int i = 0; i < 7; i++) courses[i] = List<Course>(5);
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
        courseCallback.onSuccess(courses);
      }
    }
  } on SocketException catch (_) {} finally {
    courseCallback.onFinish();
  }
}
