part of 'ble_cubit.dart';

enum BleStatus {
  searching,
  done,
  loadingPaired,
  loadedPaired,
  connected,
  failed
}

class BleState extends Equatable {
  const BleState({
    this.errorMessage,
    required this.status,
    this.devices = const [],
  });

  final String? errorMessage;
  final BleStatus status;
  final List<BluetoothDevice> devices;

  @override
  List<Object> get props => [
        status,
        errorMessage ?? "",
      ];

  BleState copyWith({
    required BleStatus status,
    String? errorMessage,
    List<BluetoothDevice> devices = const [],
  }) {
    return BleState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status,
      devices: devices,
    );
  }
}
