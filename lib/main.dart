import 'package:flutter/material.dart';
import 'package:lushlane_app/features/auth/presentation/views/login_view.dart';

void main() {
  runApp(LushLaneApp());
}

class LushLaneApp extends StatelessWidget {
  const LushLaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
