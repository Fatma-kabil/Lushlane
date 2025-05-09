import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lushlane_app/features/drawer/presentation/views/profile_view.dart';

import 'package:lushlane_app/features/drawer/presentation/views/widgets/drawer_items.dart';
import 'package:lushlane_app/features/drawer/presentation/views/widgets/header.dart';
// تأكدي من المسار الصحيح

class DrawerViewBody extends StatefulWidget {
  const DrawerViewBody({super.key});

  @override
  State<DrawerViewBody> createState() => _DrawerViewBodyState();
}

class _DrawerViewBodyState extends State<DrawerViewBody> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _navigateToProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileView()),
    );

    if (result == 'updated') {
      await user?.reload(); // أعد تحميل بيانات المستخدم
      user = FirebaseAuth.instance.currentUser;
      setState(() {}); // أعِد بناء الواجهة لتعرض البيانات الجديدة
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = user?.displayName ?? 'Guest';
    final email = user?.email ?? 'guest@example.com';

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: _navigateToProfile,
            child: Header(username: username, email: email),
          ),
          const DrawerItems(),
        ],
      ),
    );
  }
}
