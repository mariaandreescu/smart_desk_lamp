import 'package:boilerplate_app/cubit/ble_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

// @InjectableInit(
//   initializerName: r'$initGetIt', // default
//   preferRelativeImports: true, // default
//   asExtension: false, // default
// )
// void configureDependencies() => $initGetIt(getIt);

void setUpLocator() {
  getIt.registerSingleton<BleCubit>(BleCubit());
}