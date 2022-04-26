import 'package:boilerplate_app/pages/home/home_page.dart';
import 'package:boilerplate_app/pages/auth/auth_page.dart';
import 'package:boilerplate_app/resources/custom_theme.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_utils/easy_utils.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  EasyUtils.init(
    extraCalls: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyAuth.initializeFirebase(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
    appThemes: const CustomTheme(),
    child: const InitLayer(),
  );
}

class InitLayer extends StatelessWidget {
  const InitLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EasyAuthInit(
      child: EasyMaterialApp(
        debugShowCheckedModeBanner: false,
        home: EasyAuthLayer(
          unknown: CircularProgressIndicator(),
          unauthenticated: LoginPage(),
          authenticated: HomePage(),
        ),
      ),
    );
  }
}
