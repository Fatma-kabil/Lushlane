import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/resset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: RessetPasswordViewBody(),
      ),
    );
  }
}
