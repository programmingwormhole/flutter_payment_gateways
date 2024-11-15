import 'package:bkash/bkash.dart';
import 'package:get/get.dart';
import 'package:uddoktapay/models/customer_model.dart';
import 'package:uddoktapay/models/request_response.dart';
import 'package:uddoktapay/uddoktapay.dart';

void onButtonTap(String selected) async {
  switch (selected) {
    // case 'bkash':
    //   bkashPayment();
    //   break;
    case 'uddoktapay':
      uddoktapay();
      break;

    default:
      print('No gateway selected');
  }
}

double totalPrice = 1.00;

/// bKash

final bkash = Bkash(
  logResponse: true,
);

bkashPayment() async {
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

//UddoktaPay
uddoktapay() async {
  final response = await UddoktaPay.createPayment(
    context: Get.context!,
    customer: CustomerDetails(
      fullName: 'Md Shirajul Islam',
      email: 'ytshirajul@icloud.com',
    ),
    amount: totalPrice.toString(),
  );

  if (response.status == ResponseStatus.completed) {
    print(response.senderNumber);
  } else if (response.status == ResponseStatus.canceled) {
    print('Payment canceled');
  } else {
    print('Something is wrong');
  }
}
