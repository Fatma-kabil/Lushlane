import 'package:flutter/material.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/product_details_view_body.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ProductDetailsViewBody() ,
    );
  }
}
