import 'package:flutter/material.dart';
import 'package:smart_home/widgets/info_text.dart';
import '../../../../constants/contants.dart';
import '../../../../notifier/saved_device_info.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({
    super.key,
    required this.icon,
    required this.deviceInfo,
  });

  final IconData icon;
  final DeviceNotifier deviceInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 32.0,
              ),
            ),
            SwitchInfoText(
              title: deviceInfo.deviceName.isEmpty
                  ? 'No registered device found'
                  : deviceInfo.deviceName,
              subTitle: deviceInfo.deviceName.isEmpty
                  ? 'Add new device'
                  : deviceInfo.deviceAddress,
            ),
            deviceInfo.deviceName.isEmpty
                ? const Text('')
                : IconButton(
                    onPressed: () => deviceInfo.clearInfo(),
                    icon: const Icon(Icons.delete_outline_outlined),
                  ),
          ],
        ),
      ),
    );
  }
}
