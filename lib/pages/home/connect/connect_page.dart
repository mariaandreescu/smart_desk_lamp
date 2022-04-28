import 'package:boilerplate_app/cubit/ble_cubit.dart';
import 'package:boilerplate_app/injectable.dart';
import 'package:boilerplate_app/pages/home/connect/connect_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BleCubit>(),
      child: const ConnectView(),
    );
  }
}
