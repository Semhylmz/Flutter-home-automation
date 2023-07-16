import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.grey[300],
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[300],
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.grey[300],
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
);
