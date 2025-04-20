import 'package:flutter/material.dart';
import 'package:lushlane_app/features/checkout/presentation/views/widgets/checkout_footer.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/checkout/presentation/views/widgets/pot_listview_card.dart';

class CheckOutViewBody extends StatelessWidget {
  final List<PotsModel> cartItems;
  final double totalPrice;

  const CheckOutViewBody({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return const Center(
        child: Text(
          'Your cart is Empty.',
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) =>
                PotListViewCard(item: cartItems[index]),
          ),
        ),
        CheckoutFooter(totalPrice: totalPrice),
      ],
    );
  }
}
