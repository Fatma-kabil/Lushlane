import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/checkout/presentation/manager/check_cubit/checkout_cubit.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_input_model.dart';
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
      return Center(
        child: Text(
          'Your cart is Empty.',
          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
        ),
      );
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              BlocConsumer<CheckoutCubit, CheckoutState>(
                listener: (context, state) {
                  if (state is CheckoutFailure) {
                    // عرض رسالة فشل الدفع
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  } else if (state is CheckoutSuccess) {
                    // عرض رسالة نجاح الدفع
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment Successful')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      final paymentIntentInput = PaymentIntentInputModel(
                        amount: (totalPrice * 100).toInt(), // هنا نفترض أن المبلغ يتم دفعه بالدولار
                        currency: 'USD',
                        customerId: 'cus_S9t70AarbClyU5'
                        // يمكن إضافة باقي التفاصيل إذا كان هناك حاجة
                      );
                      context.read<CheckoutCubit>().makePayment(paymentIntentInputModel: paymentIntentInput);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueAccent.withOpacity(0.3),
                    ),
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
