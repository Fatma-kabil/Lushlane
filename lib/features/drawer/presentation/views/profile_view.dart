import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        title: Text(
          'Profile Page',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: ProfileViewBody(),
    );
  }
}
