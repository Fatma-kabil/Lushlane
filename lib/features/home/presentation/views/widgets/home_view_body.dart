import 'package:flutter/material.dart';
import 'package:lushlane_app/features/home/presentation/views/product_details_view.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/custom_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailsView();
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 70,
          bottom: 40,
        ),
        child: GridView.builder(
          itemCount: 20,
          clipBehavior: Clip.none,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 25,
            mainAxisSpacing: 70,
          ),
          itemBuilder: (context, index) {
            return CustomCard();
          },
        ),
      ),
    );
  }
}
