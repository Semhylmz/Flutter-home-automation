import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/view/splash_view/splash_page.dart';
import '../theme/theme_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.grey[300],
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.grey[300],
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.grey[300],
      ),
    );

    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const SplashPage(),
    );
  }
}
