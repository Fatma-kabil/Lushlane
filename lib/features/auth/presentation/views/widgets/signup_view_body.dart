import 'package:flutter/material.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/text_icon.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
           margin: EdgeInsets.symmetric(horizontal: 20,),
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
                  hintText: 'Enter your UserName :',
                  icon: const Icon(Icons.person_3_sharp),
                ), const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                CustomButton(text: 'Sign up', onTap: () {}),
                const SizedBox(height: 10),
                TextIcon(text: ' Reset password?'),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
        
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextIcon(
                      text: ' Login',
                      ontap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginView();
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
    );
  }
}
