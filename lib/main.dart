import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:lushlane_app/core/utils/api_keys.dart';
import 'package:lushlane_app/core/utils/api_service.dart';
import 'package:lushlane_app/core/utils/profile_image_manager.dart';
import 'package:lushlane_app/features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/manger/reset_password_cubit/reset_password_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';
import 'package:lushlane_app/features/drawer/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:lushlane_app/features/home/data/repos/home_repo_impl.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/cart_cubit.dart/cart_cubit.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/fetch_pots_cubit.dart';
import 'package:lushlane_app/features/home/presentation/views/home_view.dart';
import 'package:lushlane_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. إعداد مفتاح Stripe
  Stripe.publishableKey = ApiKeys.publishKey;

  // 2. إعداد Stripe بالكامل (👇 لازم تضيف السطر ده)
  await Stripe.instance.applySettings();

  // 3. تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 4. تشغيل التطبيق
  runApp(const LushLaneApp());
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
        BlocProvider( create: (context) => ProfileCubit(ProfileImageManager()),)
      ],

      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginView()),
    );
  }
}
