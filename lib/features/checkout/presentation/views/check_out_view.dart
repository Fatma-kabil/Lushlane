import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/cart_cubit.dart/cart_cubit.dart';
import 'package:lushlane_app/features/checkout/presentation/views/widgets/check_out_view_body.dart';
import 'package:lushlane_app/core/utils/widgets/custom_appbar.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Check out'),
      body: BlocBuilder<CartCubit, Map<String, dynamic>>(
        builder: (context, cartState) {
          List<PotsModel> cartItems = List<PotsModel>.from(cartState['items']);

          double totalPrice = cartItems.fold(
            0.0,
            (sum, item) => sum + item.price,
          );

          return CheckOutViewBody(
            cartItems: cartItems,
            totalPrice: totalPrice,
          );
        },
      ),
    );
  }
}

