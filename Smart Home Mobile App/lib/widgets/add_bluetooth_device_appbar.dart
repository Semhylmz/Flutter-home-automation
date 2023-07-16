import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class MAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MAppbar({
    super.key,
    required this.isAddDevicePage,
  });

  final bool isAddDevicePage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.grey[300],
      automaticallyImplyLeading: true,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_outlined),
        color: Colors.black,
      ),
      actions: [
        isAddDevicePage
            ? IconButton(
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ),
              )
            : const SizedBox(width: 0.0, height: 0.0),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
