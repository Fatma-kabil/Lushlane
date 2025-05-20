
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_state.dart';
import 'package:lushlane_app/features/drawer/presentation/views/profile_view.dart';

import 'package:lushlane_app/features/drawer/presentation/views/widgets/drawer_items.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/header.dart';
// تأكدي من المسار الصحيح
class DrawerViewBody extends StatelessWidget {
  const DrawerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        String username = 'Guest';
        String email = 'guest@example.com';

        if (state is UserProfileLoaded) {
          username = state.name ?? username;
          email = state.email ?? email;
        }

        return Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileView()),
                ),
                child: Header(username: username, email: email),
              ),
              const DrawerItems(),
            ],
          ),
        );
      },
    );
  }
}
