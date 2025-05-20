import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/core/utils/functions/save_changes.dart';
import 'package:lushlane_app/core/utils/profile_repositry.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/user_profile/user_profile_state.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/profile_form_fields.dart';

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
  // This 'isPasswordChanged' flag is not directly used in saveProfileChanges for logic flow,
  // but if you have internal UI logic dependent on it, you can keep it.
  // The 'onPasswordChanged' callback handles setting it.
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
          // This listener is for states emitted by UserProfileCubit,
          // typically for initial data loading or internal Cubit errors.
          // The success/error messages for *saving* changes are handled by saveProfileChanges.

          if (state is UserProfileError) {
            // Show error message if there's an issue loading the user profile
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
          // Do NOT show a success message here for UserProfileLoaded,
          // as it fires on initial data load, not on successful profile updates.
        },
        builder: (context, state) {
          if (state is UserProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_isInitialized) {
                // Initialize controllers with loaded data only once
                _nameController.text = state.name ?? '';
                _emailController.text = state.email ?? '';
                // Note: It's generally not recommended to store or display
                // the actual password in a controller for security reasons,
                // especially for oldPassword.
                // You might want to clear or not set _oldPasswordController.text
                // if it's meant for re-authentication before password change.
                _oldPasswordController.text = state.password ?? '';
                _isInitialized = true;
              }
            });

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ProfileFormFields(
                nameController: _nameController,
                emailController: _emailController,
                oldPasswordController: _oldPasswordController,
                passwordController: _passwordController,
                onSavePressed: () {
                  // Call your save function
                saveProfileChanges(
  context: context,
  name: _nameController.text.trim(),
  email: _emailController.text.trim(),
  password: _oldPasswordController.text.trim(), // ⬅️ الباسورد الحالية
  newPassword: _passwordController.text.trim(), // ⬅️ الباسورد الجديدة
  isPasswordChanged: isPasswordChanged,
  onPasswordChanged: () {
    setState(() {
      isPasswordChanged = true;
    });
  },
);

                },
              ),
            );
          } else if (state is UserProfileError) {
            // Display error when UserProfileError state is encountered in builder
            return Center(child: Text('Error loading profile: ${state.message}'));
          } else {
            // Fallback for other states (e.g., UserProfileLoading if you had one)
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}