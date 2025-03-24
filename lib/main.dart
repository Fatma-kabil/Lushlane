import 'package:flutter/material.dart';

void main() {
  runApp(LushLaneApp());
}

class LushLaneApp extends StatelessWidget {
  const LushLaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
