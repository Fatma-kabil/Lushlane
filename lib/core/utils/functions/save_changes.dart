import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';

Future<void> saveProfileChanges({
  required BuildContext context,
  required String name,
  required String email,
  required String password,
  required String newPassword,
  required bool isPasswordChanged,
  required void Function() onPasswordChanged,
}) async {
  final userCubit = context.read<UserProfileCubit>();
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentEmail = currentUser?.email ?? '';

  bool nameChanged = false;
  bool shouldSignOut = false;

  if (name.isNotEmpty && name != currentUser?.displayName) {
    userCubit.updateName(name);
    nameChanged = true;
  }

  if (email.isNotEmpty && email != currentEmail) {
    try {
      await userCubit.updateEmail(currentEmail, password, email);
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
      shouldSignOut = true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password update failed: ${e.toString()}'), backgroundColor: Colors.red),
      );
      return;
    }
  }

  if (!nameChanged && !shouldSignOut) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("No changes to save."),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  if (context.mounted) {
    final message = shouldSignOut
        ? "Profile updated successfully\n🔐 Please login again"
        : "✅ Profile updated successfully";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
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

