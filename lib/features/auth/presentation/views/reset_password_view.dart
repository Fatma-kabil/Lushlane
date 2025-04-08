import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/core/show_snack_bar.dart';
import 'package:lushlane_app/core/utils/loading_indecator.dart';
import 'package:lushlane_app/features/auth/presentation/manger/reset_password_cubit/reset_password_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/views/widgets/resset_password_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        
        if (state is ResetPasswordLoading) {
        } else if (state is ResetPasswordSuccess) {
          showSnakBar(context, 'Check your email to reset your password!');
        } else if (state is ResetPasswordFailure) {
          showSnakBar(context, state.errMassege);
        }
      },
      builder: (context, state) {
        bool isLoading = state is ResetPasswordLoading;

        return ModalProgressHUD(
          progressIndicator: LoadingIndecator(),
          inAsyncCall: isLoading,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: RessetPasswordViewBody(),
            ),
          ),
        );
      },
    );
  }
}
