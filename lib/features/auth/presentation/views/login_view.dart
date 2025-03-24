import 'package:flutter/material.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xffc9d7d3), body: LoginViewBody());
  }
}
