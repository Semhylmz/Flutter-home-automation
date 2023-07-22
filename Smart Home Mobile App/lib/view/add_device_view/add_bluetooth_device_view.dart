import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/model/device_model.dart';
import 'package:smart_home/notifier/saved_device_info.dart';
import 'package:smart_home/widgets/info_text.dart';
import 'package:smart_home/widgets/head_widget.dart';
import 'package:smart_home/widgets/add_bluetooth_device_appbar.dart';
import '../../../constants/size_contants.dart';
import '../home_view/home_view.dart';
import 'widgets/bluetooth_device_list.dart';
import 'widgets/device_info.dart';

class AddBluetoothDevicePage extends StatefulWidget {
  const AddBluetoothDevicePage({Key? key}) : super(key: key);

  @override
  State<AddBluetoothDevicePage> createState() => _AddBluetoothDevicePageState();
}

class _AddBluetoothDevicePageState extends State<AddBluetoothDevicePage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  late StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  late bool isDiscovering;

  List<BluetoothDiscoveryResult> results = [];

  List<DeviceModel> temp = [];

  @override
  void initState() {
    isDiscovering = false;

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    super.initState();
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        results.add(r);
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    //_streamSubscription.cancel();
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    results.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppbar(isAddDevicePage: true),
      body: Consumer<DeviceNotifier>(
        builder: (context, deviceInfo, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadWidget(title: 'Registered devices'),
              DeviceInfo(icon: Icons.devices_outlined, deviceInfo: deviceInfo),
              const HeadWidget(title: 'Add new device'),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: hPadding, vertical: vPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          _bluetoothState.isEnabled
                              ? Icons.bluetooth_connected_outlined
                              : Icons.bluetooth_disabled_outlined,
                          size: iconSize,
                        ),
                      ),
                      SwitchInfoText(
                        title: _bluetoothState.isEnabled
                            ? 'The device is expected to be selected...'
                            : 'No connection',
                        subTitle: _bluetoothState.isEnabled
                            ? 'Bluetooth on'
                            : 'Bluetooth off',
                      ),
                      CupertinoSwitch(
                        value: _bluetoothState.isEnabled,
                        onChanged: (bool value) async {
                          if (value) {
                            await FlutterBluetoothSerial.instance
                                .requestEnable()
                                .then((_) {
                              setState(() {
                                isDiscovering = true;
                              });
                              _startDiscovery();
                            });
                          } else {
                            await FlutterBluetoothSerial.instance
                                .requestDisable()
                                .then(
                                  (_) => setState(
                                    () {
                                      isDiscovering = false;
                                    },
                                  ),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: hPadding, vertical: vPadding),
                child: Visibility(
                  visible: _bluetoothState.isEnabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              isDiscovering
                                  ? 'Searching for available devices'
                                  : 'Available devices',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          isDiscovering
                              ? const Text('')
                              : _bluetoothState.isEnabled
                                  ? IconButton(
                                      onPressed: _restartDiscovery,
                                      icon: const Icon(Icons.replay_outlined),
                                    )
                                  : const Text('')
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      isDiscovering
                          ? LinearProgressIndicator(
                              color: Colors.grey[200],
                              backgroundColor: Colors.black,
                            )
                          : const SizedBox(width: 0.0, height: 0.0),
                      SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: results.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, idx) {
                            return BluetoothDeviceList(
                              device: results[idx].device,
                              rssi: results[idx].rssi,
                              onTap: () async {
                                if (results[idx].device != null) {
                                  temp.add(DeviceModel(
                                      deviceName: results[idx].device.name ??
                                          'Unkown device',
                                      deviceAddress: results[idx].device.address));

                                  deviceInfo.saveDevice(deviceInfo: temp).then((_) {
                                    temp.clear();
                                    Fluttertoast.showToast(msg: 'Device added');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const HomePage(),
                                        ),
                                        (route) => false);
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Device could not be selected! Try again',
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
