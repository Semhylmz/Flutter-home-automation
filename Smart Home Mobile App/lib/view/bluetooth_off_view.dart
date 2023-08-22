import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../constants/size_contants.dart';
import '../widgets/info_text.dart';

class BluetoothOffPage extends StatefulWidget {
  const BluetoothOffPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BluetoothOffPage> createState() => _BluetoothOffPageState();
}

class _BluetoothOffPageState extends State<BluetoothOffPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: hPadding, vertical: vPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You must turn on Bluetooth to continue.',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: headSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 25.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.bluetooth_disabled_outlined,
                        size: iconSize,
                      ),
                    ),
                    const SwitchInfoText(
                      title: 'Turn on Bluetooth.',
                      subTitle: 'Bluetooth off',
                    ),
                    CupertinoSwitch(
                      value: false,
                      onChanged: (bool value) async {
                        if (value) {
                          await FlutterBluetoothSerial.instance.requestEnable();
                        } else {}
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
