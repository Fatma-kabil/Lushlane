import 'package:dartz/dartz.dart';
import 'package:lushlane_app/core/errors/failures.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_input_model.dart';
 
 
 abstract class CheckoutRepo {
   Future<Either<Failure, void>> makePayment(
       {required PaymentIntentInputModel paymentIntentInputModel});
 }