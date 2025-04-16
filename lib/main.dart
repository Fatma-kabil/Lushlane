import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lushlane_app/core/utils/api_keys.dart';
import 'package:lushlane_app/core/utils/api_service.dart';
import 'package:lushlane_app/features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/manger/reset_password_cubit/reset_password_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:lushlane_app/features/home/data/repos/home_repo_impl.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/cart_cubit.dart/cart_cubit.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/fetch_pots_cubit.dart';
import 'package:lushlane_app/features/home/presentation/views/home_view.dart';
import 'package:lushlane_app/firebase_options.dart';

void main() async {
  Stripe.publishableKey = ApiKeys.publishKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(LushLaneApp());
}

class LushLaneApp extends StatelessWidget {
  const LushLaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ResetPasswordCubit()),
        BlocProvider(
          create:
              (context) => FetchPotsCubit(
                HomeRepoImpl(apiService: ApiService(dio: Dio())),
              ),
        ),
        BlocProvider(create: (context) => CartCubit()),
      ],

      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
    );
  }
}
