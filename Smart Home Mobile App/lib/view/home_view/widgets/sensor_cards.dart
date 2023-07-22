import 'package:flutter/material.dart';
import 'package:smart_home/view/home_view/widgets/sensor_switch.dart';
import '../../../constants/size_contants.dart';
import '../../../constants/lists.dart';
import '../../../notifier/bluetooth_notifier.dart';
import 'sensor_temp_card.dart';

class SensorListCard extends StatelessWidget {
  const SensorListCard({
    super.key,
    required this.notifier,
    required this.idx,
    required this.onChanged,
  });

  final BluetoothConnectionNotifier notifier;
  final int idx;
  final void Function(bool p1)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ValueListenableBuilder(
        valueListenable: notifier.ledNotifier,
        builder: (context, value, child) => Container(
          decoration: BoxDecoration(
            color: idx == 0
                ? value
                    ? Colors.grey[900]
                    : Colors.grey[200]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: vPadding),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  smartDevices[idx].icon,
                  size: 65.0,
                  color: idx == 0
                      ? notifier.ledNotifier.value
                          ? Colors.white
                          : Colors.black
                      : Colors.black,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          smartDevices[idx].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: sensorCardInfoSize,
                              fontWeight: FontWeight.bold,
                              color: idx == 0
                                  ? notifier.ledNotifier.value
                                      ? Colors.white
                                      : Colors.black
                                  : Colors.black),
                        ),
                      ),
                      idx == 0
                          ? SensorSwitch(
                              isHomeSwitch: true,
                              valueNotifier: notifier.ledNotifier,
                              onChanged: onChanged)
                          : idx == 1
                              ? SensorTempCardInfo(notifier: notifier, idx: idx)
                              : idx == 2
                                  ? SensorSwitch(
                                      isHomeSwitch: true,
                                      valueNotifier: notifier.ledNotifier,
                                      onChanged: onChanged)
                                  : idx == 3
                                      ? SensorSwitch(
                                          isHomeSwitch: true,
                                          valueNotifier: notifier.ledNotifier,
                                          onChanged: onChanged)
                                      : const SizedBox(height: 0.0, width: 0.0)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
