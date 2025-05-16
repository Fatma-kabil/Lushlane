import 'package:dio/dio.dart';
import 'package:lushlane_app/core/utils/api_keys.dart';
import 'package:lushlane_app/core/utils/api_service.dart';
import 'package:lushlane_app/features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:lushlane_app/features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:lushlane_app/features/checkout/data/models/payment_intent_models/payment_intent_models.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


class StripeService {
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

  Future initPaymentSheet({ required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initPaymentSheetInputModel.paymentIntentClientSecret,
          customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKeySecret,
          customerId:initPaymentSheetInputModel.customerId ,
          merchantDisplayName: 'Fatma'),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKeyModel=await createEphemeralKey(customerId: paymentIntentInputModel.customerId);
    var initPaymentSheetInputModel=InitPaymentSheetInputModel(paymentIntentClientSecret: paymentIntentModel.clientSecret!, ephemeralKeySecret:ephemeralKeyModel.secret! , customerId: paymentIntentInputModel.customerId);
    await initPaymentSheet(initPaymentSheetInputModel:initPaymentSheetInputModel);
    await displayPaymentSheet();
  }


  Future<EphemeralKeyModel> createEphemeralKey({required String customerId}) async {
    var response = await apiservice.post(
        body: {'customer':customerId},
        contentType: Headers.formUrlEncodedContentType,
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secretKey,
        headers:{
          'Authorization': "Bearer ${ApiKeys.secretKey}",
          'Stripe-Version':"2025-02-24.acacia"});
    var ephemeralkey = EphemeralKeyModel.fromJson(response.data);
    return ephemeralkey;
  }

   Future<String> createStripeCustomer({required String email}) async {
    var response = await apiservice.post(
      body: {'email': email},
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/customers',
      token: ApiKeys.secretKey,
    );

    return response.data['id']; // ده هو الـ customerId
  }

}
