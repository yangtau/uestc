// Created by Tau on 2019/1/15
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'net.dart';
import 'auth.dart';

class Grade {
  final String name;
  final String type;
  final String credit;
  final String overall;
  final String resit;
  final String finalScore;
  final String gpa;

  Grade.fromJson(Map data)
      : name = data['name'],
        type = data['type'],
        credit = data['credit'],
        overall = data['overall'],
        resit = data['resit'],
        finalScore = data['final'],
        gpa = data['gpa'];
}

Future<List<Grade>> fetchGradeBySemester() async {
  var grades = <Grade>[];
  final token = await AuthManager.fetchToken();
  if (token.isEmpty) {
//    return courses;
  }
  var header = {
    'Authorization': 'Bearer ' + token,
  };
  var postBody = {'year': '2018', 'semester': '1'};
//  TODO: add data
  try {
    var response =
        await http.post(API.gradeUrl, headers: header, body: postBody);
    if (response.statusCode != 200) {
//      courseCallback.onFailed(NetworkCode);
    } else {
      final body = json.decode(response.body);
      if (body['code'] != 201) {
//          courseCallback.onFailed(NetworkCode);
      } else {
        for (var t in body['data']) {
          grades.add(Grade.fromJson(t));
        }
      }
    }
  } on SocketException catch (_) {} finally {}
  return grades;
}
