import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/views/drawer_view.dart';

Future<void> saveProfileChanges({
  required BuildContext context,
  required String name,
  required String email,
  required String password,
  required bool isPasswordChanged,
  required void Function() onPasswordChanged,
}) async {
  if (name.isNotEmpty) {
    context.read<UserProfileCubit>().updateName(name);
  }

  if (email.isNotEmpty) {
    context.read<UserProfileCubit>().updateEmail(email);
  }

  if (password.isNotEmpty) {
    context.read<UserProfileCubit>().updatePassword(password);
    onPasswordChanged();
  }

  if (isPasswordChanged) {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
      (route) => false,
    );
  } else {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, 'updated');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DrawerView()),
      );
    }
  }
}
