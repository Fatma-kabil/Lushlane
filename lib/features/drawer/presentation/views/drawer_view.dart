import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/drawer_view_body.dart';


class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfileImage(),
      child: const DrawerViewBody(),
    );
  }
}