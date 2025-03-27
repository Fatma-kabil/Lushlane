import 'package:flutter/material.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/custom_text_field.dart';

class RessetPasswordViewBody extends StatelessWidget {
  const RessetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                ),

                const SizedBox(height: 10),
                CustomButton(text: 'Resset Password', onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
