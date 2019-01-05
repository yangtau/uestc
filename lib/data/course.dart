// Created by Tau on 2019/01/01
import 'package:http/http.dart' as http;
import 'dart:io';

import 'api.dart';
import 'auth.dart';
import 'network_callback.dart';

class Course {
  final String name, id, teacher, room;
  Map<int, int> _time; //key 1~7, value 1~5
  Map<int, int> get time => _time;
  Course.fromJson(Map json)
      : name = json['courseName'],
        id = json['courseId'],
        teacher = json['teacher'],
        room = json['room'] {
    List<List<int>> time = json['time'];
    for (var t in time) {
      int section;
      if (t[1] < 2) {
        section = 1;
      } else if (t[1] < 4) {
        section = 2;
      } else if (t[1] < 6) {
        section = 3;
      } else if (t[1] < 8) {
        section = 4;
      } else {
        section = 5;
      }
      _time[t[0] + 1] = section;
    }
  }
}

const NoTokenCode = 1;

Future<void> fetchCourses(Callback<List<Course>> courseCallback) async {
  courseCallback.onStart();
  final auth = await AuthManager.getInstance();
  final token = await auth.fetchToken();
  if (token.isEmpty) {
    courseCallback.onFailed(NoTokenCode);//
    courseCallback.onFinish();
    return;
  }
  try {
    
  } on SocketException catch (_) {}
  finally {
    courseCallback.onFinish();
  }
}
