import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: colorBackground,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: colorBackground,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: colorBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
);
