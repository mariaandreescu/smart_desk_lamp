import 'package:boilerplate_app/pages/auth/login/login_fields.dart';
import 'package:boilerplate_app/resources/strings.dart';
import 'package:easy_utils/easy_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              HSpace(MediaQuery.of(context).size.height * 0.25),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Hero(
                        tag: Strings.title,
                        child: FittedBox(
                          child: Text(
                            Strings.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: const Color(0xFF272C38)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => Stack(
                    children: const [
                      LoginFields(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
