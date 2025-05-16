
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:lushlane_app/features/checkout/presentation/manager/check_cubit/checkout_cubit.dart';
import 'package:lushlane_app/features/checkout/presentation/views/thank_you_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CheckoutFooter extends StatelessWidget {
  final double totalPrice;

  const CheckoutFooter({required this.totalPrice});

  Future<String?> getCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('stripeCustomerId');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getCustomerId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // ممكن تحطي سبينر أو placeholder
          return const Center(child: CircularProgressIndicator());
        }

        final customerId = snapshot.data ?? '';

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4),
            ],
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  } else if (state is CheckoutSuccess) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ThankYouView(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CheckoutLoading) {
                    return const CircularProgressIndicator(color: Colors.grey);
                  }

                  return ElevatedButton(
                    onPressed: () {
                      final input = PaymentIntentInputModel(
                        amount: (totalPrice * 100).toInt(),
                        currency: 'USD',
                        customerId: customerId,
                      );

                      context
                          .read<CheckoutCubit>()
                          .makePayment(paymentIntentInputModel: input);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 12),
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
        );
      },
    );
  }
}
