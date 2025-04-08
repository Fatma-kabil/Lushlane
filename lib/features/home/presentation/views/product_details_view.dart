import 'package:flutter/material.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/product_details_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'details screen'),
      backgroundColor: Colors.white,
      body: ProductDetailsViewBody(),
    );
  }
}
