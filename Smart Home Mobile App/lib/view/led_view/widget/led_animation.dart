import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/notifier/bluetooth_serial_notifier.dart';
import '../../../constants/lists.dart';

class LedAnimation extends StatelessWidget {
  const LedAnimation({
    super.key,
    required this.idx,
  });

  final int idx;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ledAnimationName[idx],
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            ValueListenableBuilder(
              valueListenable:
                  context.watch<BluetoothSerialNotifier>().ledAnimNotifier,
              builder: (context, value, child) => Radio(
                value: ledAnimationName[idx],
                groupValue: value,
                activeColor: Colors.green,
                onChanged: (value) {
                  Provider.of<BluetoothSerialNotifier>(context,
                          listen: false)
                      .changeLedAnimation(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
