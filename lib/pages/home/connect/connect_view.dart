import 'package:boilerplate_app/cubit/ble_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Container(),
    );
  }
}
