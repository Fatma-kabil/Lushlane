import 'package:flutter/material.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/check_out_view_body.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/custom_appbar.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key, });
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Check out'),
      body: CheckOutViewBody(),
    );
  }
}
