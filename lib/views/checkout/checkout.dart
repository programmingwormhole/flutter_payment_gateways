import 'package:flutter/material.dart';
import 'package:payment_gateways/views/checkout/helpers/payment_helper.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? selected;

  List<Map> gateways = [
    {
      'name': 'bKash',
      'logo':
          'https://freelogopng.com/images/all_img/1656234841bkash-icon-png.png',
    },
    {
      'name': 'UddoktaPay',
      'logo':
          'https://uddoktapay.com/assets/images/xlogo-icon.png.pagespeed.ic.IbVircDZ7p.png',
    },
    {
      'name': 'SslCommerz',
      'logo':
          'https://apps.odoo.com/web/image/loempia.module/193670/icon_image?unique=c301a64',
    },
    {
      'name': 'ShurjoPay',
      'logo':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGhMPK0wqLrv9z2Z2NKU17pUIpadsmODtVSQ&s',
    },
    {
      'name': 'RazorPay',
      'logo':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX_ZUKUT0JfSN8NHyaVBIlwr7MHsdrvSvopQ&s',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: false,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Select a payment method',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      return PaymentMethodTile(
                        logo: gateways[index]['logo'],
                        name: gateways[index]['name'],
                        selected: selected ?? '',
                        onTap: () {
                          selected = gateways[index]['name']
                              .toString()
                              .replaceAll(' ', '_')
                              .toLowerCase();
                          setState(() {});
                        },
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: gateways.length,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap:
                  selected == null ? null : () => onButtonTap(selected ?? ''),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: selected == null
                      ? Colors.blueAccent.withOpacity(.5)
                      : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Continue to payment',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String logo;
  final String name;
  final Function()? onTap;
  final String selected;

  const PaymentMethodTile({
    super.key,
    required this.logo,
    required this.name,
    this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected == name.replaceAll(' ', '_').toLowerCase()
                ? Colors.blueAccent
                : Colors.black.withOpacity(.1),
            width: 2,
          ),
        ),
        child: ListTile(
          leading: Image.network(
            logo,
            height: 35,
            width: 35,
          ),
          title: Text(name),
        ),
      ),
    );
  }
}
