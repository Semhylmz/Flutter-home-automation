import 'package:flutter/material.dart';
import 'package:smart_home/notifier/bluetooth_notifier.dart';
import 'package:smart_home/view/home_view/widgets/sensor_switch.dart';
import 'package:smart_home/view/led_view/widget/led_animation.dart';
import 'package:smart_home/widgets/title_widget.dart';
import 'package:smart_home/widgets/add_bluetooth_device_appbar.dart';
import '../../constants/contants.dart';
import '../../constants/lists.dart';
import '../../widgets/info_text.dart';

class LedPage extends StatefulWidget {
  const LedPage({Key? key, required this.valueNotifier}) : super(key: key);

  final BluetoothConnectionNotifier valueNotifier;

  @override
  State<LedPage> createState() => _LedPageState();
}

class _LedPageState extends State<LedPage> {
  double _value = 255;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppbar(isAddDevicePage: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleWidget(title: 'Neopixel Led Status'),
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.lightbulb_outline, size: 32.0),
                  ),
                  SwitchInfoText(
                      title: 'Neopixel Led',
                      subTitle: widget.valueNotifier.ledNotifier.value
                          ? 'On'
                          : 'Off'),
                  SensorSwitch(
                      isHomeSwitch: false,
                      onChanged: (bool value) {
                        widget.valueNotifier.changeLedState();
                        setState(() {});
                      },
                      valueNotifier: widget.valueNotifier.ledNotifier),
                  /*CupertinoSwitch(
                    value: widget.valueNotifier.ledNotifier.value,
                    onChanged: (bool value) {
                      widget.valueNotifier.changeLedState();
                      setState(() {});
                    },
                  ),*/
                ],
              ),
            ),
          ),
          const TitleWidget(title: 'Brightness'),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: hPadding, vertical: vPadding),
            child: Slider(
              min: 0.0,
              max: 255.0,
              divisions: 10,
              label: '${_value.round()}',
              inactiveColor: Colors.white,
              thumbColor: Colors.white,
              activeColor: _value >= 0.0 && _value < 85.0
                  ? Colors.greenAccent
                  : _value > 85.0 && _value < 170.0
                      ? Colors.orangeAccent
                      : _value > 170 && _value <= 255.0
                          ? Colors.redAccent
                          : null,
              value: _value,
              onChangeEnd: (value) {},
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
          const TitleWidget(title: 'Animations'),
          Expanded(
            child: ListView.builder(
              itemCount: ledAnimationName.length,
              padding: const EdgeInsets.all(vPadding),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, idx) {
                return LedAnimation(
                  idx: idx,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
