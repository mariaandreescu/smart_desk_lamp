import 'package:boilerplate_app/resources/strings.dart';
import 'package:easy_auth/easy_auth.dart';
import 'package:easy_utils/easy_utils.dart';
import 'package:flutter/material.dart';

class ResetPasswordFields extends StatelessWidget {
  const ResetPasswordFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyAuthResetPasswordProvider(
      onSuccess: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'The email has been sent to your email address.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
      },
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                HSpace(MediaQuery.of(context).size.height * 0.05),
                ResetPasswordEmailField(
                  height: 80,
                  errorText: Strings.errorInvalidEmail,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: "Email",
                  ),
                ),
                PasswordResetButton(
                  child: Text(
                    'Reset password',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
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
