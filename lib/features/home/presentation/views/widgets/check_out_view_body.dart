import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/cart_cubit.dart/cart_cubit.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/pot_listview_card.dart';

class CheckOutViewBody extends StatelessWidget {
  const CheckOutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, Map<String, dynamic>>(
      builder: (context, cartState) {
        List<PotsModel> cartItems = List<PotsModel>.from(cartState['items']);

        double totalPrice = cartItems.fold(
          0.0,
          (sum, item) => sum + item.price,
        );

        if (cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return PotListViewCard(item: item);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // يمكنك إضافة الكود الخاص بالدفع هنا
                      print('Proceed to payment');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      //  primary: Colors.blueAccent, // لون الزر
                         padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 12), // زيادة ارتفاع الزر
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // حواف مستديرة
                      ),
                      elevation: 5, // إضافة ظل بسيط للزر لجعلها أكثر بروزًا
                      shadowColor: Colors.blueAccent.withOpacity(
                        0.3,
                      ), // لون الظل
                    ),
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(
                        fontSize: 18, // حجم الخط
                        fontWeight: FontWeight.w600, // سمك الخط
                        color: Colors.white, // لون النص
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}