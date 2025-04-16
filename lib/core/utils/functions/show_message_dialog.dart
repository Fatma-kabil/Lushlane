import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';

void showMessageDialog(BuildContext context, void Function()? onpressed) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('Check Your Email ✉️'),
          content: Text('We’ve sent a password reset link to your email.'),
          actions: [
            TextButton(
              onPressed: onpressed,

              child: Text('OK', style: TextStyle(color: kPrimaryColor)),
            ),
          ],
        ),
  );
}
