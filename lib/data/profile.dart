// Created by Tao Yang on 2019/01/10
import 'net.dart' as net;
import 'package:http/http.dart' as http;
import 'dart:io';

class User {
  final String avatarUrl;
  final String nickName;
  final String bio;
  final String stuID;
  final String stuName;
  final String enName;
  final String gender;
  final String grade;
  final String plan;
  final String project;
  final String level;
  final String category;
  final String department;
  final String profession;
  final String enrollDate;
  final String graduateDate;
  final String manager;
  final String waysOfLearning;
  final String status;
  final String registered;
  final String atSchool;
  final String class_;
  final String campus;

  User.fromJson(Map data)
      : avatarUrl = data['avatarUrl'],
        nickName = data['nickName'],
        bio = data['bio'],
        stuID = data['stuID'],
        stuName = data['stuName'],
        enName = data['enName'],
        gender = data['gender'],
        grade = data['grade'],
        plan = data['plan'],
        project = data['project'],
        level = data['level'],
        category = data['category'],
        department = data['department'],
        profession = data['profession'],
        enrollDate = data['enrollDate'],
        graduateDate = data['graduateDate'],
        manager = data['manager'],
        waysOfLearning = data['waysOfLearning'],
        status = data['status'],
        registered = data['registered'],
        atSchool = data['atSchool'],
        class_ = data['class'],
        campus = data['campus'];
}

Future<User> fetchProfile() async {

}