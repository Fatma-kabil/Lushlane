import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/core/utils/widgets/show_snack_bar.dart';
import 'package:lushlane_app/core/utils/widgets/loading_indecator.dart';
import 'package:lushlane_app/features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:lushlane_app/features/home/presentation/views/home_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
        //  print('Loading...');
        } else if (state is LoginSuccess) {
         // print('login Successful!');
         
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );
        } else if (state is LoginFailure) {
        //  print('login Failed: ${state.errMassege}');
          showSnakBar(context, state.errMassege);
        }
      },
      builder: (context, state) {
        bool isLoading = state is LoginLoading;
       //  debugPrint('isLoading: $isLoading');
        return ModalProgressHUD(
          progressIndicator: LoadingIndecator(),
          inAsyncCall: isLoading,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: LoginViewBody(),
            ),
          ),
        );
      },
    );
  }
}

