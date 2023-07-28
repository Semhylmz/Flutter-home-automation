import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:smart_home/notifier/bluetooth_notifier.dart';
import 'package:smart_home/view/home_view/widgets/sensor_switch.dart';
import 'package:smart_home/widgets/head_widget.dart';
import 'package:smart_home/widgets/add_bluetooth_device_appbar.dart';
import '../../constants/size_contants.dart';
import '../../widgets/info_text.dart';

class LedPage extends StatefulWidget {
  const LedPage({Key? key, this.valueNotifier}) : super(key: key);

  final BluetoothConnectionNotifier? valueNotifier;

  @override
  State<LedPage> createState() => _LedPageState();
}

class _LedPageState extends State<LedPage> {
  double _value = 255;
  late final circleColorPickerController;

  @override
  void dispose() {
    // TODO: implement dispose
    circleColorPickerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    circleColorPickerController =
        CircleColorPickerController(initialColor: Colors.green);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MAppbar(isAddDevicePage: false),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadWidget(title: 'Neopixel Led Status'),
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
                          child: Icon(Icons.lightbulb_outline, size: iconSize),
                        ),
                        SwitchInfoText(
                            title: 'Neopixel Led',
                            subTitle: widget.valueNotifier!.ledNotifier.value
                                ? 'On'
                                : 'Off'),
                        SensorSwitch(
                            isHomeSwitch: false,
                            onChanged: (bool value) {
                              widget.valueNotifier!.changeLedState();
                              setState(() {});
                            },
                            valueNotifier: widget.valueNotifier!.ledNotifier),
                      ],
                    ),
                  ),
                ),
                const HeadWidget(title: 'Light Color'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: hPadding, vertical: vPadding),
                  child: Center(
                    child: CircleColorPicker(
                      size: const Size(240, 240),
                      strokeWidth: 4,
                      thumbSize: 36,
                      textStyle: const TextStyle(color: Colors.transparent),
                      controller: circleColorPickerController,
                      onChanged: (colorVal) {
                        setState(() {
                          circleColorPickerController.color = colorVal;
                        });
                      },
                    ),
                  ),
                ),
                const HeadWidget(title: 'Brightness'),
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
                /*Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: hPadding, vertical: vPadding),
                  child: ColorPicker(
                    paletteType: PaletteType.hueWheel,
                    hexInputBar: true,
                    pickerColor: Colors.red,
                    onColorChanged: (v) {},
                  ),
                ),*/
                /*const TitleWidget(title: 'Animations'),
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
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
