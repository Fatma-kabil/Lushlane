import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.hintText,
    this.icon,
    this.onchanged,
    this.obscureText = false,
  });
  String? hintText;
  Icon? icon;
  bool obscureText = false;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: Color(0xffb0d5ca),
      style: const TextStyle(color: Colors.black54),
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is reqired';
        }
        return null;
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        filled: true, // ضروري لتفعيل اللون
        fillColor: Colors.grey[200],
        suffixIcon: icon,

        suffixIconColor: Color(0xffb0d5ca),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
