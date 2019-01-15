// Created by Tau on 2018/12/30
import 'package:flutter/material.dart';

final _primaryColor = Colors.black87;
final _accentColor = Colors.red[700];
const buttonHeight = 60.0;
const normalPadding = 8.0;
const normalBorderRadius = 5.0;

final themeData = ThemeData(
//  primaryColor: _primaryColor,
  accentColor: _primaryColor,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderSide: BorderSide(color: _primaryColor, width: 1.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _primaryColor, width: 1.5)),
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: _primaryColor)),
  ),
  buttonTheme: ButtonThemeData(
    minWidth: double.infinity,
    height: buttonHeight,
  ),
);

class TextStyles {
  static const AppbarTitle = TextStyle(
    color: Colors.black87,
    fontFamily: 'Viga',
    fontSize: 30,
    fontWeight: FontWeight.w100,
  );
  static const CardInfo = const TextStyle(
    color: Colors.black54,
    fontSize: 10,
  );
  static const CardTile = const TextStyle(
    color: Colors.black87,
    fontSize: 14,
  );
  static const HeaderInfo = const TextStyle(
    color: Colors.black54,
    fontSize: 14,
  );
  static const HeaderTitle = const TextStyle(
    color: Colors.black87,
    fontSize: 20,
  );
  static const DrawerItem = const TextStyle(
    color: Colors.black87,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 1
  );
}
