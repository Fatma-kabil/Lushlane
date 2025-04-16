import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/core/utils/widgets/show_snack_bar.dart';
import 'package:lushlane_app/features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/views/reset_password_view.dart';
import 'package:lushlane_app/features/auth/presentation/views/signup_view.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_text_field.dart';

import 'package:lushlane_app/features/auth/presentation/views/widgets/text_icon.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  GlobalKey<FormState> formkey = GlobalKey();

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    onchanged: (data) {
                      email = data;
                      email = email?.trim();
                    },
                    hintText: 'Enter your Email :',
                    icon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    onchanged: (data) {
                      password = data;
                      password = password?.trim();
                    },
                    obscureText: true,
                    hintText: 'Enter your Password :',
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Login',
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(
                          context,
                        ).loginUser(email: email!, password: password!);
                      } else {
                        showSnakBar(
                          context,
                          'Please enter  email and password',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  TextIcon(
                    text: ' Reset password?',
                    ontap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ResetPasswordView();
                          },
                        ),
                      );
                    },
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

                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextIcon(
                        text: ' Sign up',
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignupView();
                              },
                            ),
                          );
                        },
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
