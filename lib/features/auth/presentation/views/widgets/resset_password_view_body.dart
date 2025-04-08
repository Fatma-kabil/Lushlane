import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/auth/presentation/manger/reset_password_cubit/reset_password_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_text_field.dart';

class RessetPasswordViewBody extends StatelessWidget {
  RessetPasswordViewBody({super.key});
  GlobalKey<FormState> formkey = GlobalKey();

  String? email;

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
                  Text(
                    'Enter your Email to reset your password',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,

                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter your Email :',
                    icon: const Icon(Icons.email),
                    onchanged: (data) {
                      email = data;
                      email = email?.trim();
                    },
                  ),

                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Resset Password',
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<ResetPasswordCubit>(
                          context,
                        ).resetPassword(email: email!);
                      }
                    },
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
