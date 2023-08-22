import 'package:flutter/material.dart';
import 'package:smart_home/notifier/bluetooth_serial_notifier.dart';
import 'package:smart_home/view/home_view/widgets/sensor_cards.dart';
import 'package:smart_home/view/led_view/led_view.dart';
import '../../temp_view/temp_view.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({
    super.key,
    required this.notifier,
    required this.idx,
    this.onChanged,
  });

  final BluetoothSerialNotifier notifier;
  final int idx;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        idx == 0
            ? showBottomSheet(context: context, builder: (context) => LedPage(valueNotifier: notifier),)
        /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LedPage(valueNotifier: notifier)))*/
            : idx == 1
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TempPage()))
                : null;
        /*idx == 2
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MotionPage()))
                    : idx == 3
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AudioPage()))
                        : null;*/
      },
      child: SensorListCard(notifier: notifier, idx: idx, onChanged: onChanged),
    );
  }
}
