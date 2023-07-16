import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/device_model.dart';

class DeviceNotifier extends ChangeNotifier {
  late SharedPreferences _sharedPreferences;
  late String _deviceName;
  late String _deviceAddress;

  String get deviceName => _deviceName;

  String get deviceAddress => _deviceAddress;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    getDeviceInfo();
    notifyListeners();
  }

  Future<void> saveDevice({required List<DeviceModel> deviceInfo}) async {
    /// [0]: device name, [1]: device address
    _sharedPreferences.setStringList(
        'deviceInfo', [deviceInfo[0].deviceName, deviceInfo[0].deviceAddress]);
    getDeviceInfo();
    notifyListeners();
  }

  void getDeviceInfo() {
    List<String>? list = _sharedPreferences.getStringList('deviceInfo') ?? [];
    list.isEmpty ? _deviceName = '' : _deviceName = list[0];
    list.isEmpty ? _deviceAddress = '' : _deviceAddress = list[1];

    notifyListeners();
  }

  void clearInfo() {
    _sharedPreferences.clear();
    getDeviceInfo();
    notifyListeners();
  }
}
