import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_gateways/views/checkout/checkout.dart';
import 'package:shurjopay/utilities/functions.dart';

void main() {
  initializeShurjopay(environment: 'sandbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment Gateways',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Checkout(),
    );
  }
}
