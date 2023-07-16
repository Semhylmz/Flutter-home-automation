import 'package:flutter/cupertino.dart';

class SensorSwitch extends StatelessWidget {
  const SensorSwitch({
    super.key,
    required this.onChanged,
    required this.valueNotifier,
    required this.isHomeSwitch,
  });

  final void Function(bool p1)? onChanged;
  final ValueNotifier valueNotifier;
  final bool isHomeSwitch;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, child) => RotatedBox(
        quarterTurns: isHomeSwitch ? 1 : 0,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
