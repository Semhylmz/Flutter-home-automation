import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/notifier/bluetooth_notifier.dart';
import '../../notifier/saved_device_info.dart';
import '../home_view/home_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isOk = false;

  @override
  void initState() {
    setProviders();
    super.initState();
  }

  Future<void> setProviders() async {
    await Provider.of<DeviceNotifier>(context, listen: false).init().then(
          (_) =>
              Provider.of<BluetoothConnectionNotifier>(context, listen: false)
                  .initBluetoothState()
                  .then(
                    (_) => routePage(),
                  ),
        );
  }

  void routePage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            child: const Icon(
              Icons.home_outlined,
              size: 72,
            ),
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          const Spacer(),
        ],
      ),
    );
  }
}
