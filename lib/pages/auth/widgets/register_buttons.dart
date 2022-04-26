import 'package:boilerplate_app/resources/strings.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterButtons extends StatelessWidget {
  const RegisterButtons({Key? key}) : super(key: key);

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
            Navigator.pop(context);
          },
          child: Text(
            "Already have an account? Login",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    );
  }
}
