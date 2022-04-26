import 'package:boilerplate_app/resources/strings.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_utils/easy_utils.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            HSpace(MediaQuery.of(context).size.height * 0.05),
            LoginEmailField(
              height: 80,
              errorText: Strings.errorInvalidEmail,
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Email",
              ),
            ),
            LoginPasswordField(
              height: 80,
              errorText: Strings.errorInvalidPassword,
              decoration: InputDecoration(
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Password",
              ),
            ),
            LoginButton(
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.button!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
