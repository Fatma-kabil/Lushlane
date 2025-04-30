import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/drawer_items.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/header.dart';

class DrawerViewBody extends StatelessWidget {
  const DrawerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          final username = user?.displayName ?? 'Guest';
          final email = user?.email ?? 'guest@example.com';

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Header(username: username, email: email),
              DrawerItems(),
            ],
          );
        },
      ),
    );
  }
}
