import 'package:boilerplate_app/cubit/ble_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';

class ConnectView extends StatelessWidget {
  const ConnectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to device"),
        actions: [
          GestureDetector(
            onTap: () {
              context.read<BleCubit>().search();
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<BleCubit, BleState>(
        builder: (context, state) {
          // print(state.devices);
          // print(state.status);
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.devices.length,
            itemBuilder: (context, index) {
              return Card(
                child: StreamBuilder<BluetoothDeviceState>(
                  stream: state.devices[index].state,
                  initialData: BluetoothDeviceState.disconnected,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: snapshot.data == BluetoothDeviceState.connected
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.devices[index].name),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (snapshot.data ==
                                        BluetoothDeviceState.connected) {
                                      state.devices[index].disconnect();
                                    } else {
                                      state.devices[index].connect();
                                    }
                                  },
                                  child:
                                      // snapshot.data == BluetoothDeviceState.connected
                                      //     ? const Text('Disconnect')
                                      const Text('Disconnect'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (snapshot.data ==
                                        BluetoothDeviceState.disconnected) {
                                    } else {
                                      final List<BluetoothService> services =
                                          state.devices[index].name == "ESP32"
                                              ? await state.devices[index]
                                                  .discoverServices()
                                              : [];
                                      services[2].characteristics[1].write(
                                            utf8.encode('1'),
                                          );
                                    }
                                  },
                                  child: const Text('ON'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (snapshot.data ==
                                        BluetoothDeviceState.disconnected) {
                                    } else {
                                      final List<BluetoothService> services =
                                          state.devices[index].name == "ESP32"
                                              ? await state.devices[index]
                                                  .discoverServices()
                                              : [];
                                      services[2].characteristics[1].write(
                                            utf8.encode('0'),
                                          );
                                    }
                                  },
                                  child: const Text('OFF'),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(state.devices[index].name),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (snapshot.data ==
                                          BluetoothDeviceState.connected) {
                                        state.devices[index].disconnect();
                                      } else {
                                        state.devices[index].connect();
                                      }
                                    },
                                    child: const Text('Connect'),
                                  ),
                                ]),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
