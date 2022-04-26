import 'package:boilerplate_app/pages/register/register_page.dart';
import 'package:boilerplate_app/pages/reset_password/reset_password.dart';
import 'package:boilerplate_app/resources/strings.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_utils/easy_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            EasyUtils.push(context, const ResetPasswordPage());
          },
          child: Text(
            "Forgot your password?",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    );
  }
}
