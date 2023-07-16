import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/notifier/bluetooth_notifier.dart';
import 'package:smart_home/notifier/saved_device_info.dart';
import 'package:smart_home/view/splash_view/splash_page.dart';
import 'package:smart_home/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => DeviceNotifier()),
        Provider(create: (_) => BluetoothConnectionNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

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
      theme: themeData,
      home: const SplashPage(),
    );
  }
}
