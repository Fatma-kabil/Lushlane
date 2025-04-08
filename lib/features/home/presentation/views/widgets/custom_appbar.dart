import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      scrolledUnderElevation: 0.0,
      backgroundColor: kPrimaryColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: 20,
            color: Colors.white,
          ),
        ),
        Text(
          '  \$105    ',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ],
      title: const Text(
        'Home',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
