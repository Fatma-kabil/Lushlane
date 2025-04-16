import 'package:dartz/dartz.dart';
import 'package:lushlane_app/core/errors/failures.dart';
import 'package:lushlane_app/core/utils/stripe_service.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_model.dart';
import 'package:lushlane_app/features/checkout/data/repos/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
   final StripeService stripeService = StripeService();
   @override
   Future<Either<Failure, void>> makePayment(
       {required PaymentIntentInputModel paymentIntentInputModel}) async {
     try {
       await stripeService.makePayment(
           paymentIntentInputModel: paymentIntentInputModel);
       return right(null);
     } catch (e) {
       return left(ServerFailure( e.toString()));
     }
   }
 }