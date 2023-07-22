import 'package:flutter/material.dart';
import 'package:smart_home/widgets/head_widget.dart';
import '../../../constants/size_contants.dart';
import '../../add_device_view/add_bluetooth_device_view.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({
    super.key,
    required this.isConnecting,
  });

  final bool isConnecting;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: homeSizedHeight),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: hPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello',
                      style: TextStyle(
                          fontSize: infoTextSize, color: Colors.grey[700])),
                  const Text('Semih',
                      style: TextStyle(fontSize: infoTextSize * 2)),
                  // Text(
                  //   'Temperature today X°',
                  //   style: TextStyle(
                  //       fontSize: infoTextOptionalSize,
                  //       color: Colors.grey[700]),
                  // ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddBluetoothDevicePage(),
                    ),
                  );
                },
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Icon(
                    Icons.devices_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: hPadding),
          child: isConnecting
              ? LinearProgressIndicator(
                  color: Colors.grey[200],
                  backgroundColor: Colors.black,
                )
              : Divider(thickness: 1.0, color: Colors.grey[400]),
        ),
        const SizedBox(height: homeSizedHeight),
        const HeadWidget(title: 'Connection Status')
      ],
    );
  }
}
