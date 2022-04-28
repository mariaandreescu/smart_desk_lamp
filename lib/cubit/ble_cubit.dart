import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:injectable/injectable.dart';

part 'ble_state.dart';

@singleton
class BleCubit extends Cubit<BleState> {
  List<BluetoothDevice> devices = [];

  BleCubit() : super(const BleState(status: BleStatus.searching, devices: []));

  Future<void> search() async {
    print(state);
    if (state.status == BleStatus.connected) {
      return;
    }
    if (state.status == BleStatus.searching) {
      try {
        FlutterBlue.instance.startScan().timeout(const Duration(seconds: 5));
        FlutterBlue.instance.scanResults
            .listen((List<ScanResult> results) async {
          for (ScanResult result in results) {
            devices.add(result.device);
            print(result.device);
            if (result.device.id.toString() == "BE:AC:10:00:00:01") {
              print("attempting to connect to ${result.device.id}");
              await result.device.connect();
            }
          }
        });
        FlutterBlue.instance.stopScan();
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
