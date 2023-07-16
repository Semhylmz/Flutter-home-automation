import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/notifier/bluetooth_notifier.dart';
import 'package:smart_home/notifier/saved_device_info.dart';
import 'package:smart_home/view/home_view/widgets/home_info.dart';
import 'package:smart_home/widgets/info_text.dart';
import '../../constants/contants.dart';
import '../../constants/lists.dart';
import '../../widgets/title_widget.dart';
import 'widgets/sensors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Provider.of<BluetoothConnectionNotifier>(context, listen: false)
        .disposeMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<BluetoothConnectionNotifier>(context, listen: true)
        .initBluetoothStream();

    return Consumer<BluetoothConnectionNotifier>(
      builder: (context, valueNotifier, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeInfo(isConnecting: valueNotifier.isConnecting),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: hPadding, vertical: vPadding),
                  child: Container(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            valueNotifier.isConnected()
                                ? Icons.bluetooth_connected_outlined
                                : Icons.bluetooth_disabled_outlined,
                            size: 32.0,
                          ),
                        ),
                        SwitchInfoText(
                          title: valueNotifier.bluetoothState.isEnabled
                              ? valueNotifier.isConnecting
                                  ? 'Connecting to ${context.watch<DeviceNotifier>().deviceName} device..'
                                  : valueNotifier.isConnected()
                                      ? 'Connected ${context.watch<DeviceNotifier>().deviceName} device'
                                      : !valueNotifier.isConnected() &&
                                              context
                                                  .watch<DeviceNotifier>()
                                                  .deviceName
                                                  .isNotEmpty
                                          ? 'Connection lost'
                                          : 'Paired device not found, add new device'
                              : 'No connection',
                          subTitle: valueNotifier.bluetoothState.isEnabled
                              ? 'Bluetooth on'
                              : 'Bluetooth off',
                        ),
                        CupertinoSwitch(
                          value: valueNotifier.bluetoothState.isEnabled
                              ? true
                              : false,
                          onChanged: (bool value) async {
                            if (value) {
                              await FlutterBluetoothSerial.instance
                                  .requestEnable()
                                  .then((_) {
                                setState(() {});
                              });
                            } else {
                              await FlutterBluetoothSerial.instance
                                  .requestDisable()
                                  .then((_) => Future.delayed(
                                        const Duration(milliseconds: 300),
                                        () => setState(() {}),
                                      ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const TitleWidget(title: 'Sensors'),
                Expanded(
                  child: GridView.builder(
                    itemCount: smartDevices.length,
                    padding: const EdgeInsets.all(vPadding),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemBuilder: (context, idx) {
                      return SensorCard(
                        notifier: valueNotifier,
                        idx: idx,
                        onChanged: (bool state) async {
                          valueNotifier.isConnected()
                              ? valueNotifier.changeLedState()
                              : Fluttertoast.showToast(msg: 'No connection');
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
