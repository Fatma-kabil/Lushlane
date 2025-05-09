import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/core/utils/profile_repositry.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';

import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_state.dart';
import 'package:lushlane_app/features/drawer/presentation/views/drawer_view.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/Profile_image_with_edit_button.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/custom_profile_text_field.dart';


class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  bool _isInitialized = false;
  bool isPasswordChanged = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _oldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileCubit(ProfileRepository())..loadUserData(),
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileLoaded) {
            // Show success message when profile is loaded
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully')),
            );
          } else if (state is UserProfileError) {
            // Show error message if there's an issue
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is UserProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            if (!_isInitialized) {
              _nameController.text = state.name ?? '';
              _emailController.text = state.email ?? '';
              _oldPasswordController.text =
                  state.password ?? ''; // عرض الباسورد القديم فقط كمخفي
              _isInitialized = true;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ProfileImageWithEditButton(),
                  // Profile Image (if any)
                  const SizedBox(height: 30),
                  CustomProfileTextField(
                    controller: _nameController,
                    label: 'Edit Name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 25),
                  CustomProfileTextField(
                    controller: _emailController,
                    label: 'Edit Email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 25),
                  CustomProfileTextField(
                    controller: _oldPasswordController,
                    label: 'Old Password',
                    icon: Icons.lock,
                    obscureText: true,
                    enabled: false,
                  ),
                  const SizedBox(height: 25),
                  CustomProfileTextField(
                    controller: _passwordController,
                    label: 'New Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () async {
                      final name = _nameController.text.trim();
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      if (name.isNotEmpty) {
                        context.read<UserProfileCubit>().updateName(name);
                      }
                      if (email.isNotEmpty) {
                        context.read<UserProfileCubit>().updateEmail(email);
                      }
                      if (password.isNotEmpty) {
                        context.read<UserProfileCubit>().updatePassword(
                          password,
                        );
                        isPasswordChanged = true;
                      }
                      if (isPasswordChanged) {
                        // لو غيّر الباسورد ➜ نعمله تسجيل خروج ونرجعه لشاشة تسجيل الدخول
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (route) => false,
                        );
                      } else {
                        // لو بس غيّر الاسم أو الإيميل ➜ يرجع للشاشة اللي قبلها (drawer)
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context,'updated');
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DrawerView(),
                            ),
                          );
                        }
                      }
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
