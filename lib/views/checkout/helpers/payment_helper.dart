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
  bkashCredentials: const BkashCredentials(
    username: '01750387497',
    password: 'Z7+i9YS8o9Z',
    appKey: 'sGVwP9DLmuOIvcumTixdcS7gtc',
    appSecret: '9DvpRRNZTi1K0mUVAe7MgFz5FdZvdkHvnywZQMX7eT6zZknr3e16',
    isSandbox: false,
  ),
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
