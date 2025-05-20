import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';

Future<void> saveProfileChanges({
  required BuildContext context,
  required String name,
  required String email,
  required String password,       // الباسورد الحالية
  required String newPassword,    // الباسورد الجديدة (اختياري)
  required bool isPasswordChanged,
  required void Function() onPasswordChanged,
}) async {
  final userCubit = context.read<UserProfileCubit>();
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentEmail = currentUser?.email ?? '';

  bool hasChanges = false;
  bool shouldSignOut = false;

  if (name.isNotEmpty && name != currentUser?.displayName) {
    userCubit.updateName(name);
    hasChanges = true;
  }

  if (email.isNotEmpty && email != currentEmail) {
    try {
      await userCubit.updateEmail(currentEmail, password, email);
      hasChanges = true;
      shouldSignOut = true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email update failed: ${e.toString()}'), backgroundColor: Colors.red),
      );
      return;
    }
  }

  if (newPassword.isNotEmpty) {
    try {
      await userCubit.updatePassword(currentEmail, password, newPassword);
      onPasswordChanged();
      hasChanges = true;
      shouldSignOut = true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password update failed: ${e.toString()}'), backgroundColor: Colors.red),
      );
      return;
    }
  }

  if (!hasChanges) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("No changes to save."),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text("Profile updated successfully"),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  if (shouldSignOut) {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginView()),
        (route) => false,
      );
    }
  }
}
