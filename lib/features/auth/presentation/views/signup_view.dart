import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/core/show_snack_bar.dart';
import 'package:lushlane_app/core/utils/loading_indecator.dart';
import 'package:lushlane_app/features/auth/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/signup_view_body.dart';
import 'package:lushlane_app/features/home/presentation/views/home_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {
        if (state is SignupLoading) {
          //   print('Loading...');
        } else if (state is SignupSuccess) {
          //   print('Signup Successful!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        } else if (state is SignupFailure) {
          //  print('Signup Failed: ${state.errMassege}');
          showSnakBar(context, state.errMassege);
        }
      },
      builder: (context, state) {
        bool isLoading = state is SignupLoading;

        return ModalProgressHUD(
          progressIndicator: LoadingIndecator(),
          inAsyncCall: isLoading,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: SignupViewBody(),
            ),
          ),
        );
      },
    );

    // SafeArea(child: Scaffold(backgroundColor: kPrimaryColor, body: SignupViewBody()));
  }
}
