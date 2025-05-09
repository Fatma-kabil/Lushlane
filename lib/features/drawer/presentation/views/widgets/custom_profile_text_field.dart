import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final bool enabled;

  const CustomProfileTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: enabled ? Colors.black : Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
      ),
    );
  }
}
