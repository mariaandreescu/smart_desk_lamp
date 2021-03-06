import 'package:boilerplate_app/pages/auth/forgotten_password/forgotten_password_page.dart';
import 'package:boilerplate_app/pages/auth/register/register_page.dart';
import 'package:boilerplate_app/resources/strings.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_utils/easy_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginFields extends StatelessWidget {
  const LoginFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyAuthLoginProvider(
      onFailure: (error) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                error,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
      },
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                HSpace(MediaQuery.of(context).size.height * 0.05),
                LoginEmailField(
                  height: 80,
                  errorText: Strings.errorInvalidEmail,
                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                LoginPasswordField(
                  height: 80,
                  errorText: Strings.errorInvalidPassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                LoginButton(
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
                HSpace(MediaQuery.of(context).size.height * 0.04),
              ],
            ),
            Column(
              children: [
                GoogleLoginButton(
                  child: SvgPicture.asset(
                    Strings.googleIcon,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    EasyUtils.push(context, const RegisterPage());
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                HSpace(MediaQuery.of(context).size.height * 0.02),
                GestureDetector(
                  onTap: () {
                    EasyUtils.push(context, const ForgottenPasswordPage());
                  },
                  child: Text(
                    "Forgot your password?",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
