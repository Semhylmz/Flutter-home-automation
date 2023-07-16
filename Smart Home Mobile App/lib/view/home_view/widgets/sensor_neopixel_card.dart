import 'package:flutter/cupertino.dart';
import '../../../notifier/bluetooth_notifier.dart';

class SensorNeoPixelCardInfo extends StatelessWidget {
  const SensorNeoPixelCardInfo({
    super.key,
    required this.notifier,
    required this.onChanged,
  });

  final BluetoothConnectionNotifier notifier;
  final void Function(bool p1)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier.ledNotifier,
      builder: (context, value, child) => RotatedBox(
        quarterTurns: 1,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
