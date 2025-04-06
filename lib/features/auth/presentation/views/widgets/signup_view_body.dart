import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/core/show_snack_bar.dart';
import 'package:lushlane_app/features/auth/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/text_icon.dart';


class SignupViewBody extends StatelessWidget {
  SignupViewBody({super.key});

  GlobalKey<FormState> formkey = GlobalKey();

  String? name;

  String? email;

  String? password;

  

  @override
  Widget build(BuildContext context) {
    return  Form(
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
                        name = data;
                      },
                          hintText: 'Enter your UserName :',
                          icon: const Icon(Icons.person_3_sharp),
                        ),
                        const SizedBox(height: 15),
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
                      },
                          obscureText: true,
                          hintText: 'Enter your Password :',
                          icon: const Icon(Icons.remove_red_eye),
                        ),
                        const SizedBox(height: 15),
                        CustomButton(text: 'Sign up',  onTap: () async {
                          print('Sign up button clicked');
                        if (formkey.currentState!.validate()) {
                          if (email != null && password != null && name!=null) {
                            BlocProvider.of<SignupCubit>(context)
                                .signupUser(email: email!, password: password!, name: name!);
                          } else {
                            showSnakBar(context,
                                'Please enter name, email and password');
                          }
                        }
                      },),
          
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
            ),
          
        );
      
    
  }
}
