import 'package:flutter/material.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/presentation/views/product_details_view.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/custom_card.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key, required this.pots});
  List<PotsModel> pots;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 70, bottom: 40),
      child: GridView.builder(
        itemCount: pots.length,
        clipBehavior: Clip.none,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 25,
          mainAxisSpacing: 70,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProductDetailsView(pot: pots[index]);
                  },
                ),
              );
            },
            child: CustomCard(
              pot: pots[index],
            ), // Ensure your CustomCard widget is set up to take `pot`
          );
        },
      ),
    );
  }
}
