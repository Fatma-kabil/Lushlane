import 'package:flutter/material.dart';
import 'package:lushlane_app/core/utils/functions/show_logout_dialog.dart';
import 'package:lushlane_app/features/checkout/presentation/views/check_out_view.dart';
import 'package:lushlane_app/features/home/presentation/views/home_view.dart';

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap:
              () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeView()),
                (route) => false,
              ),
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text('My Products'),
          onTap:
              () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CheckOutView()),
              ),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () => Navigator.pop(context),
        ),

        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () => showLogoutDialog(context),
        ),
      ],
    );
  }
}
