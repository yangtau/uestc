// Created by Tau on 2019/1/1
import 'package:flutter/material.dart';
import 'package:uestc/login/login_view.dart';
import 'package:uestc/home/home_view.dart';

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => HomePage(),
  '/': (BuildContext context) => LoginPage(),
};
