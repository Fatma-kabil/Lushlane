import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/signup_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(backgroundColor: kPrimaryColor, body: LoginViewBody()));
  }
}
