
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PropertyPayment {
  Map<String, dynamic>? paymentIntent;

  Future<bool> makePayment(BuildContext context) async {
    try {
      // STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(
        '59',
        'AED',
        'customer@example.com',
        'Charge for the ad',
      );

      // STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret:
              paymentIntent!['client_secret'], // Gotten from payment intent
          style: ThemeMode.light,
          merchantDisplayName: 'Ikay',
        ),
      );

      // STEP 3: Display Payment Sheet
      final isSuccess = await displayPaymentSheet(context);
      return isSuccess;
    } catch (err) {
      showSnackBar(context, 'Something went wrong, please try again');
      log('Payment Error: $err');
      return false;
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
    String email,
    String name,
  ) async {
    try {
      final price = calculateAmount(amount);

      // Request body
      final Map<String, dynamic> body = {
        'amount': price,
        'currency': currency,
        'description': name,
      };

      // Make post request to Stripe
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> displayPaymentSheet(BuildContext context) async {
    bool isSuccess = false;
    try {
      await Stripe.instance.presentPaymentSheet().then((result) {
        showSnackBar(context, 'Payment Successful');
        paymentIntent = null;
        isSuccess = true;
      }).onError((error, stackTrace) {
        throw Exception('Payment failed: $error');
      });
      return isSuccess;
    } on StripeException catch (e) {
      log('Stripe Error: $e');
      showSnackBar(context, 'Payment Failed: ${e.error}');
      return false;
    } catch (e) {
      log('Error: $e');
      showSnackBar(context, 'Payment Canceled');
      return false;
    }
  }

  String calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(text),
        ),
      );
  }
}
