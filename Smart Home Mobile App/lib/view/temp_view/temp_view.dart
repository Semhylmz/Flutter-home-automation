import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/widgets/head_widget.dart';
import '../../constants/size_contants.dart';
import '../../widgets/add_bluetooth_device_appbar.dart';
import '../../widgets/info_text.dart';

class TempPage extends StatefulWidget {
  const TempPage({super.key});

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MAppbar(isAddDevicePage: false),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadWidget(title: 'Temperature Settings'),
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
                      child: Icon(Icons.mode_fan_off_outlined, size: iconSize),
                    ),
                    const SwitchInfoText(title: 'Fan', subTitle: 'Off'),
                    Transform.scale(
                      scale: switchScale,
                      child: CupertinoSwitch(
                        value: false,
                        onChanged: (bool value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
