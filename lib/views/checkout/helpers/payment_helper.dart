import 'package:bkash/bkash.dart';
import 'package:get/get.dart';

void onButtonTap(String selected) async {
  switch (selected) {
    case 'bkash':
      bkashPayment();
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
