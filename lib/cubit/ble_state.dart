part of 'ble_cubit.dart';

enum BleStatus { searching, loaded, connected, failed }

class BleState extends Equatable {
  const BleState({
    this.errorMessage,
    required this.status,
    required this.devices,
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
    required List<BluetoothDevice> devices,
  }) {
    return BleState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status,
      devices: this.devices,
    );
  }
}
