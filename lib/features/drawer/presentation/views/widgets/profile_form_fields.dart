import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/profile_image_with_edit_button.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/custom_profile_text_field.dart';
// داخل ProfileFormFields (غير TextField لـ TextFormField وأضف validator)
class ProfileFormFields extends StatelessWidget {
  const ProfileFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.oldPasswordController,
    required this.passwordController,
    required this.onSavePressed,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController oldPasswordController;
  final TextEditingController passwordController;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const ProfileImageWithEditButton(),
        const SizedBox(height: 30),
        CustomProfileTextField(
          controller: nameController,
          label: 'Edit Name',
          icon: Icons.person,
        ),
        const SizedBox(height: 25),
        CustomProfileTextField(
          controller: emailController,
          label: 'Edit Email',
          icon: Icons.email,
        ),
        const SizedBox(height: 25),
        CustomProfileTextField(
          controller: oldPasswordController,
          label: 'Old Password',
          icon: Icons.lock,
          obscureText: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your current password';
            }
            return null;
          },
        ),
        const SizedBox(height: 25),
        CustomProfileTextField(
          controller: passwordController,
          label: 'New Password',
          icon: Icons.lock,
          obscureText: true,
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: kPrimaryColor,
          ),
          onPressed: onSavePressed,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
