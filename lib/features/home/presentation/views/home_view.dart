import 'package:flutter/material.dart';

import 'package:lushlane_app/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/custom_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: InkWell(
        onTap: () {},
        child: CustomCard(),
      ),
    );
  }
}
