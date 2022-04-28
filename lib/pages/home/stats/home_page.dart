import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  @override
  Widget build(BuildContext context) {
    List<Container> containers = [];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              TextButton(
                child: const Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  //widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    print(e);
                  }
                  final _connectedDevice = device;
                  print(_connectedDevice.name);
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      // body: Column(
      //   children: const <Widget>[
      //     LogoutButton(
      //       child: Text('log out'),
      //     ),
      //   ],
      // ),

      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ...containers,
        ],
      ),
    );
  }
}
