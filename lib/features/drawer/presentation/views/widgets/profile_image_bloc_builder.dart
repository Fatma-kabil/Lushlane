import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/profile_cubit/profile_cubit.dart';

class ProfileImageBlocBuilder extends StatelessWidget {
  const ProfileImageBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CircleAvatar(
            radius: 40,
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          return CircleAvatar(
            radius: 40,
            backgroundImage: FileImage(state.profileImage),
          );
        } else if (state is ProfileFailure) {
          return const CircleAvatar(
            radius: 40,
            child: Icon(Icons.error, color: Colors.red),
          );
        } else {
          return const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/user.png"),
          );
        }
      },
    );
  }
}
