// Pay with modal
import 'package:flutter/material.dart';

Future<dynamic> openPayWithModal(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _optionContainer(
              Icons.close,
              'Pay with',
              () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            const SizedBox(height: 10),
            _optionContainer(Icons.wallet, 'Google play', () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Google play selected!'),
                ),
              );
              Navigator.pop(context);
            }, Colors.black54),
            _optionContainer(Icons.credit_card, 'Credit or debit card', () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Credit or debit card selected'),
                ),
              );
              Navigator.pop(context);
            }, Colors.black54),
            _optionContainer(Icons.paypal, 'Paypal', () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Paypal selected'),
                ),
              );
              Navigator.pop(context);
            }, Colors.black54),
            _optionContainer(Icons.qr_code, 'Scan', () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Scan selected'),
                ),
              );
              Navigator.pop(context);
            }, Colors.black54),
          ],
        ),
      );
    },
  );
}

//Pay with modal options
Widget _optionContainer(IconData iconData, String text, VoidCallback? onTap,
    [Color color = Colors.black]) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.black,
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
