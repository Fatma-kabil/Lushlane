import 'package:flutter/material.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_text_field.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 200),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    hintText: 'Enter your Email :',
                    icon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    obscureText: true,
                    hintText: 'Enter your Password :',
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(text: 'Login', onTap: () {}),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      ' Reset password?',
                      style: TextStyle(
                        color: Color(0xffb0d5ca),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don’t have an account?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          ' Sign in',
                          style: TextStyle(
                            color: Color(0xffb0d5ca),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
