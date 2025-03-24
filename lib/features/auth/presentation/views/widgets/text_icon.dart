import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';

class TextIcon extends StatelessWidget {
  TextIcon({super.key, required this.text, this.ontap});

  void Function()? ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Text(
        text,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
