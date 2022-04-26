import 'package:flutter/material.dart';

class ResetPasswordButtons extends StatelessWidget {
  const ResetPasswordButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Go back to login",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    );
  }
}
