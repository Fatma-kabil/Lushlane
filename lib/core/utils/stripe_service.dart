import 'package:dio/dio.dart';
import 'package:lushlane_app/core/utils/api_keys.dart';
import 'package:lushlane_app/core/utils/api_service.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_models/payment_intent_models.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {

// PaymentIntentModel createPaymentIntent(PaymentIntentInputModel paymentIntentInputModel)
final ApiService apiservice = ApiService(dio: Dio());
   Future<PaymentIntentModels> createPaymentIntent(
       PaymentIntentInputModel paymentIntentInputModel) async {
     var response = await apiservice.post(
         body: paymentIntentInputModel.toJson(),
         contentType: Headers.formUrlEncodedContentType,
         url: 'https://api.stripe.com/v1/payment_intents',
         token: ApiKeys.secretKey);
     var paymentIntentModel = PaymentIntentModels.fromJson(response.data);
     return paymentIntentModel;
   }

    Future initPaymentSheet({required String paymentIntentClientSecret}) async {
     Stripe.instance.initPaymentSheet(
       paymentSheetParameters: SetupPaymentSheetParameters(
           paymentIntentClientSecret: paymentIntentClientSecret,
           merchantDisplayName: 'Fatma'),
     );
   }

   Future displayPaymentSheet() async {
     Stripe.instance.presentPaymentSheet();
   }

    Future makePayment(
       {required PaymentIntentInputModel paymentIntentInputModel}) async {
     var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
     await initPaymentSheet(
         paymentIntentClientSecret: paymentIntentModel.clientSecret!);
     await displayPaymentSheet();
   }
}

