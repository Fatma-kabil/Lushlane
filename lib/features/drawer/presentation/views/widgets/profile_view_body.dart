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
// داخل ProfileViewBody (StatefulWidget)
class _ProfileViewBodyState extends State<ProfileViewBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isInitialized = false;
  bool isPasswordChanged = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileCubit(ProfileRepository())..loadUserData(),
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserProfileInitial || state is UserProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_isInitialized) {
                _nameController.text = state.name ?? '';
                _emailController.text = state.email ?? '';
                _oldPasswordController.text = '';
                _passwordController.text = '';
                _isInitialized = true;
              }
            });

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Form(
                key: _formKey,
                child: ProfileFormFields(
                  nameController: _nameController,
                  emailController: _emailController,
                  oldPasswordController: _oldPasswordController,
                  passwordController: _passwordController,
                  onSavePressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveProfileChanges(
                        context: context,
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _oldPasswordController.text.trim(),
                        newPassword: _passwordController.text.trim(),
                        isPasswordChanged: isPasswordChanged,
                        onPasswordChanged: () {
                          setState(() {
                            isPasswordChanged = true;
                          });
                        },
                      );
                    }
                  },
                ),
              ),
            );
          } else if (state is UserProfileError) {
            return Center(
              child: Text('Error loading profile: ${state.message}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
