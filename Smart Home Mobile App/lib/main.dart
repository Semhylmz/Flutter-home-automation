import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/notifier/bluetooth_serial_notifier.dart';
import 'package:smart_home/notifier/saved_device_info.dart';
import 'package:smart_home/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => DeviceNotifier()),
        Provider(create: (_) => BluetoothSerialNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}
