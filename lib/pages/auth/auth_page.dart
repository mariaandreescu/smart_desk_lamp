import 'package:boilerplate_app/pages/auth/widgets/login_buttons.dart';
import 'package:boilerplate_app/pages/auth/widgets/register_buttons.dart';
import 'package:boilerplate_app/pages/auth/widgets/login_fields.dart';
import 'package:boilerplate_app/pages/auth/widgets/register_fields.dart';
import 'package:boilerplate_app/pages/auth/widgets/reset_password_buttons.dart';
import 'package:boilerplate_app/pages/auth/widgets/reset_password_fields.dart';
import 'package:boilerplate_app/resources/strings.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_utils/easy_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        toolbarOpacity: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Placeholder(
              fallbackHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            Expanded(
              flex: 1,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoginFields(),
                      Column(
                        children: [
                          GoogleLoginButton(
                            child: SvgPicture.asset(
                              Strings.googleIcon,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print(controller.page);
                              if (controller.hasClients) {
                                controller.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Text(
                              "Don't have an account? Register",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          HSpace(MediaQuery.of(context).size.height * 0.02),
                          GestureDetector(
                            onTap: () {
                              print(controller.page);
                              if (controller.hasClients) {
                                controller.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Text(
                              "Forgot your password?",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RegisterFields(),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(controller.page);
                              if (controller.hasClients) {
                                controller.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Text(
                              "Already have an account? Log in",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ResetPasswordFields(),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(controller.page);
                              if (controller.hasClients) {
                                controller.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Text(
                              "Go back to login",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
