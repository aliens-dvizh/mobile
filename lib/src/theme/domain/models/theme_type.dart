import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark;

  ThemeData toTheme() => switch(this) {
      ThemeType.light =>ThemeData.light(),
      ThemeType.dark => ThemeData.dark(),
    };
}