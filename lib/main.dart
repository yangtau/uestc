// Created by Tau on 2018/12/31
import 'package:flutter/material.dart';
import 'theme.dart';
import 'routes.dart';
import 'package:flutter/services.dart';

main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UESTC',
      theme: themeData,
      routes: routes,
      debugShowCheckedModeBanner: false,
//      showPerformanceOverlay: true,
    );
  }
}
