// Created by Tau on 2018/12/30
import 'package:flutter/material.dart';

final _primaryColor = Colors.grey[900];
final _accentColor = Colors.red[700];
const buttonHeight = 60.0;
const normalPadding = 8.0;
const normalBorderRadius = 4.0;

var themeData = ThemeData(
  primaryColor: _primaryColor,
  accentColor: _accentColor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide(color: _primaryColor)),
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: _primaryColor)),
  ),
  buttonTheme: ButtonThemeData(
    minWidth: double.infinity,
    height: buttonHeight,
  ),
);
