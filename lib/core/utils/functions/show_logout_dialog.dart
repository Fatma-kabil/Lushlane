
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';

void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text('Cancel',style: TextStyle(color: kPrimaryColor),),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // 🔥 Sign out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginView()),
                (route) => false,
              );
            },
            child: const Text('Logout',style: TextStyle(color: kPrimaryColor)),
          ),
        ],
      ),
    );
  }
