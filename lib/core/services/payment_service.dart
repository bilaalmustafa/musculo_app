import 'dart:convert';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentService {
  static Future<bool> initPaymentSheet({
    required String email,
    required double amount,
  }) async {
    try {
      final callable = FirebaseFunctions.instance.httpsCallable(
        'stripePaymentintentRequest',
      );
      final result = await callable.call({
        'email': email,
        'amount': (200 * 100).toInt(),
        'currency': 'usd',
      });

      final jsonResponse = result.data;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse["paymentIntent"],
          merchantDisplayName: "flutter mosculo stripe",
          customerId: jsonResponse["customer"],
          customerEphemeralKeySecret: jsonResponse["ephemeralKey"],
          style: ThemeMode.light,
        ),
      );
      try {
        await Stripe.instance.presentPaymentSheet();
        Fluttertoast.showToast(msg: "Payment Successful");
      } on StripeException catch (e) {
        Fluttertoast.showToast(
          msg: "Payment cancelled or failed: ${e.error.localizedMessage}",
        );
      } catch (e) {
        Fluttertoast.showToast(msg: "Unknown error: $e");
      }
      Fluttertoast.showToast(msg: "Payment Completed");
      return true;
    } catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
          msg: "Error from Stripe ${e.error.localizedMessage}",
        );
        return false;
      } else {
        Fluttertoast.showToast(msg: "Error: $e");
        log(" errrror: $e");
        return false;
      }
    }
  }
}
