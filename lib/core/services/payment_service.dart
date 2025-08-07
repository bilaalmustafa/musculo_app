import 'dart:convert';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentService {
  Future<bool> initPaymentSheet({
    required String email,
    required double amount,
  }) async {
    try {
      if (amount < 0.5) {
        Fluttertoast.showToast(msg: "Minimum payment amount is €0.50");
        return false;
      }
      final callable = FirebaseFunctions.instance.httpsCallable(
        'stripePaymentintentRequest',
      );
      final result = await callable.call({
        'email': email,
        'amount': (amount * 100).toInt(),
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
        Fluttertoast.showToast(msg: "Payment Completed");
      } on StripeException catch (e) {
        Fluttertoast.showToast(
          msg: "Stripe error: ${e.error.localizedMessage}",
        );
        log("Error during payment: ${e.error.localizedMessage}");
        return false;
      } catch (e) {
        Fluttertoast.showToast(msg: "Error: $e");
        log("Error during payment: $e");
        return false;
      }
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
