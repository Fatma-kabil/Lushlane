import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/cart_cubit.dart/cart_cubit.dart';
import 'package:lushlane_app/features/checkout/presentation/views/check_out_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, Map<String, dynamic>>(
      builder: (context, cartState) {
        return AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          scrolledUnderElevation: 0.0,
          backgroundColor: kPrimaryColor,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // الانتقال إلى صفحة السلة عند الضغط على أيقونة السلة
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckOutView(
                        )));
                  },
                ),
                Positioned(
                  right: 8,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartState['itemCount'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '  \$ ${cartState['totalPrice'].toStringAsFixed(2)}    ',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
