import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/core/utils/profile_repositry.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(); // لو حابة

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileCubit(ProfileRepository())..loadUserData(),
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            // نحدّث الكنترولر بالقيم الحالية مره واحده
            _nameController.text = state.name ?? '';
            _emailController.text = state.email ?? '';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // حقول التعديل
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Edit Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Edit Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
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
                        context.read<UserProfileCubit>().updatePassword(password);
                      }
                    },
                    child: const Text('Save Changes'),
                  ),
                  const SizedBox(height: 15.0),
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
