import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/core/utils/profile_repositry.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/profile_image_bloc_builder.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController(); // جديد

  bool _isInitialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _oldPasswordController.dispose(); // تأكد من تفريغ المتحكم الجديد عند انتهاء الصفحة
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
            // Initialize the controllers with data if not initialized
            if (!_isInitialized) {
              _nameController.text = state.name ?? '';
              _emailController.text = state.email ?? '';
              _isInitialized = true;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ProfileImageBlocBuilder(),
                  const SizedBox(height: 30),
                  // Edit Name
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Edit Name',
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  // Edit Email
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Edit Email',
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  // Display Old Password (Read-only and Hidden as Stars)
                  TextField(
                    controller: TextEditingController(text: "secretPassword"), // استخدام controller
                    obscureText: true, // إخفاء النص بنجوم
                    enabled: false, // منع التعديل
                    decoration: const InputDecoration(
                      labelText: 'Old Password',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  // New Password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text.trim();
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      final oldPassword =
                          _oldPasswordController.text.trim(); // جديد

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
                      }

                      // Send the old password if you are validating or updating it
                      if (oldPassword.isNotEmpty) {
                        // هنا لو محتاجين نستخدم كلمة المرور القديمة في التحقق أو تحديث
                        context.read<UserProfileCubit>().updatePassword(
                          oldPassword,
                        );
                      }

                      // Reload user data after updates
                      context.read<UserProfileCubit>().loadUserData();
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
