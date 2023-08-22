import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_home/constants/lists.dart';
import 'package:smart_home/notifier/saved_device_info.dart';

class BluetoothSerialNotifier extends ChangeNotifier {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  var _bluetoothConnection;

  late bool _isConnecting;

  BluetoothState get bluetoothState => _bluetoothState;

  get bluetoothConnection => _bluetoothConnection;

  bool get isConnecting => _isConnecting;

  late ValueNotifier<bool> ledNotifier;
  late ValueNotifier<String> tempNotifier;
  late ValueNotifier<String> ledAnimNotifier;

  set setLedIsActive(bool value) {
    ledNotifier.value = value;
    notifyListeners();
  }

  set setLedAnimation(String value) {
    ledAnimNotifier.value = value;
    notifyListeners();
  }

  set setTemp(String value) {
    tempNotifier.value = value;
    notifyListeners();
  }

  set setBluetoothState(BluetoothState value) {
    _bluetoothState = value;
    notifyListeners();
  }

  set setBluetoothConnection(value) {
    _bluetoothConnection = value;
    notifyListeners();
  }

  set setIsConnecting(bool value) {
    _isConnecting = value;
    notifyListeners();
  }

  void changeLedAnimation(String value) {
    bluetoothConnection.output.add(utf8.encode('$value '));
  }

  void changeLedState() {
    ledNotifier.value
        ? bluetoothConnection.output.add(utf8.encode("close "))
        : bluetoothConnection.output.add(utf8.encode("open "));
    ledNotifier.value = !ledNotifier.value;
  }

  void dataReceivedStream() {
    bluetoothConnection.input.listen((Uint8List data) {
      String dataString = ascii.decode(data);

      int space = dataString.indexOf(' ') + 1;
      dataString.startsWith('N')
          ? setLedIsActive =
              dataString.substring(space, dataString.length).contains('1')
                  ? true
                  : false
          : dataString.startsWith('T')
              ? setTemp = dataString
              : dataString.startsWith('A')
                  ? setLedAnimation =
                      dataString.substring(space, dataString.length)
                  : null;
    }).onDone(() {
      !isConnected()
          ? print('Disconnecting locally!')
          : print('Disconnected remotely!');
    });
  }

  void initBluetoothStream() {
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState event) {
      setBluetoothState = event;
    });

    _bluetoothState.isEnabled & !isConnected()
        ? connectBluetooth()
        : !_bluetoothState.isEnabled & isConnected()
            ? disposeMethod()
            : null;
  }

  Future<void> initBluetoothState() async {
    await FlutterBluetoothSerial.instance.state.then(
      (value) => setBluetoothState = value,
    );
    setIsConnecting = false;
    ledNotifier = ValueNotifier<bool>(false);
    tempNotifier = ValueNotifier<String>('Data is being updated..');
    ledAnimNotifier = ValueNotifier<String>(ledAnimationName[1]);
  }

  Future<void> connectBluetooth() async {
    if (!isConnected()) {
      setIsConnecting = true;
      setLedIsActive = false;
      String deviceAddress = DeviceNotifier().deviceAddress;
      BluetoothConnection.toAddress(deviceAddress).then((value) {
        setBluetoothConnection = value;
        setIsConnecting = false;
        dataReceivedStream();
      }).catchError(
        (err) => throw err,
      );
      setIsConnecting = false;
    } else {
      dataReceivedStream();
    }
  }

  void disposeMethod() {
    setIsConnecting = false;
    if (isConnected()) {
      FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
      bluetoothConnection.dispose();
      setBluetoothConnection = null;
    } else {
      null;
    }
  }

  bool isConnected() {
    return _bluetoothConnection != null && _bluetoothConnection.isConnected;
  }
}
