import 'package:flutter/material.dart';
import '../../../notifier/bluetooth_serial_notifier.dart';

class SensorTempCardInfo extends StatelessWidget {
  const SensorTempCardInfo({
    super.key,
    required this.notifier,
    required this.idx,
  });

  final BluetoothSerialNotifier notifier;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier.tempNotifier,
      builder: (context, value, child) => Text(
        notifier.isConnected()
            ? value.contains("Data's being taken.")
                ? "Data's being taken."
                : '$value°'
            : '',
        maxLines: 2,
        style: const TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
