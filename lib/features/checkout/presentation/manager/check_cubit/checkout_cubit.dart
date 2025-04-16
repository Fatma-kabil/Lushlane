import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_model.dart';
import 'package:lushlane_app/features/checkout/data/repos/checkout_repo.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());


   final CheckoutRepo checkoutRepo;
   Future makePayment(
       {required PaymentIntentInputModel paymentIntentInputModel}) async {
     emit(CheckoutLoading());
 
     var data = await checkoutRepo.makePayment(
         paymentIntentInputModel: paymentIntentInputModel);
 
     data.fold(
       (l) => (CheckoutFailure(errMessage: l.errorMessage)),
       (r) => CheckoutSuccess(),
     );
   }
 
   void onChange(Change<CheckoutState> change) {
     log(change.toString());
     super.onChange(change);
   }
 
}
