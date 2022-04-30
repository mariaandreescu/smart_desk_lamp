import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:injectable/injectable.dart';

part 'ble_state.dart';

@singleton
class BleCubit extends Cubit<BleState> {
  List<BluetoothDevice> devices = [];

  BleCubit()
      : super(const BleState(status: BleStatus.loadingPaired, devices: []));

  Future<void> search() async {
    emit(state.copyWith(status: BleStatus.searching));
    try {
      devices = [...await FlutterBlue.instance.connectedDevices];
      print(await FlutterBlue.instance.connectedDevices);
      emit(state.copyWith(
        status: BleStatus.loadedPaired,
        devices: devices,
      ));
      await FlutterBlue.instance.startScan(
        timeout: const Duration(seconds: 5),
      );
      FlutterBlue.instance.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (result.device.type == BluetoothDeviceType.le &&
              !devices.contains(result.device)) {
            devices.add(result.device);
          }
        }
      });
      FlutterBlue.instance.stopScan();
      emit(state.copyWith(
        status: BleStatus.done,
        devices: devices,
      ));
    } on Exception catch (e) {
      print(e);
    }
  }
}
