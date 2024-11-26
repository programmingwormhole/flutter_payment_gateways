import 'dart:convert';
import 'package:bkash/bkash.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';
import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/shurjopay.dart';
import 'package:uddoktapay/models/customer_model.dart';
import 'package:uddoktapay/models/request_response.dart';
import 'package:uddoktapay/uddoktapay.dart';

void onButtonTap(String selected) async {
  switch (selected) {
    case 'bkash':
      bkashPayment();
      break;

    case 'uddoktapay':
      uddoktapay();
      break;

    case 'sslcommerz':
      sslcommerz();
      break;

    case 'shurjopay':
      shurjoPay();
      break;

    default:
      print('No gateway selected');
  }
}

double totalPrice = 1.00;

/// bKash
bkashPayment() async {
  final bkash = Bkash(
    logResponse: true,
  );

  try {
    final response = await bkash.pay(
      context: Get.context!,
      amount: totalPrice,
      merchantInvoiceNumber: 'Test0123456',
    );

    print(response.trxId);
    print(response.paymentId);
  } on BkashFailure catch (e) {
    print(e.message);
  }
}

/// UddoktaPay
void uddoktapay() async {
  final response = await UddoktaPay.createPayment(
    context: Get.context!,
    customer: CustomerDetails(
      fullName: 'Md Shirajul Islam',
      email: 'ytshirajul@icould.com',
    ),
    amount: totalPrice.toString(),
  );

  if (response.status == ResponseStatus.completed) {
    print('Payment completed, Trx ID: ${response.transactionId}');
    print(response.senderNumber);
  }

  if (response.status == ResponseStatus.canceled) {
    print('Payment canceled');
  }

  if (response.status == ResponseStatus.pending) {
    print('Payment pending');
  }
}

/// SslCommerz
void sslcommerz() async {
  Sslcommerz sslcommerz = Sslcommerz(
    initializer: SSLCommerzInitialization(
      multi_card_name: "visa,master,bkash",
      currency: SSLCurrencyType.BDT,
      product_category: "Digital Product",
      sdkType: SSLCSdkType.TESTBOX,
      store_id: "your_store_id",
      store_passwd: "your_store_password",
      total_amount: totalPrice,
      tran_id: "TestTRX001",
    ),
  );

  final response = await sslcommerz.payNow();

  if (response.status == 'VALID') {
    print(jsonEncode(response));

    print('Payment completed, TRX ID: ${response.tranId}');
    print(response.tranDate);
  }

  if (response.status == 'Closed') {
    print('Payment closed');
  }

  if (response.status == 'FAILED') {
    print('Payment failed');
  }
}

void shurjoPay() async {
  final shurjoPay = ShurjoPay();

  final paymentResponse = await shurjoPay.makePayment(
    context: Get.context!,
    shurjopayRequestModel: ShurjopayRequestModel(
      configs: ShurjopayConfigs(
        prefix: 'NOK',
        userName: 'sp_sandbox',
        password: 'pyyk97hu&6u6',
        clientIP: '127.0.0.1',
      ),
      currency: 'BDT',
      amount: totalPrice,
      orderID: 'test00255588',
      customerName: 'Md Shirajul Islam',
      customerPhoneNumber: '+8801700000000',
      customerAddress: 'Dhaka, Bangladesh',
      customerCity: 'Dhaka',
      customerPostcode: '1000',
      returnURL: 'url',
      cancelURL: 'url',
    ),
  );


  if (paymentResponse.status == true) {

    try {

      final verifyResponse = await shurjoPay.verifyPayment(orderID: paymentResponse.shurjopayOrderID!);

      if (verifyResponse.spCode == '1000') {
        print(verifyResponse.bankTrxId);
      } else {
        print(verifyResponse.spMessage);
      }

      // if (verifyResponse.bankTrxId == null || verifyResponse.bankTrxId!.isEmpty || verifyResponse.bankTrxId == '') {
      //
      //   print('Something is wrong with your payment');
      //
      // }
      // else {
      //
      //   print(verifyResponse.bankTrxId);
      //   print(verifyResponse.message);
      //
      // }


    } catch (e) {
      print(e);
    }


  }


}
