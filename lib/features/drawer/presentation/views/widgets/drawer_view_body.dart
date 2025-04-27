import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/profile_cubit/profile_cubit.dart';

class DrawerViewBody extends StatelessWidget {
  const DrawerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
   return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    BlocBuilder<ProfileCubit, ProfileState>(
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
                            backgroundImage: AssetImage("assets/images/test.png"),
                          );
                        }
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          context.read<ProfileCubit>().pickImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "John Doe", // دينامك بعدين لو عايزه
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "john.doe@example.com", // دينامك بعدين لو عايزه
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}