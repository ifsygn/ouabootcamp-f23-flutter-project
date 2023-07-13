import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonateWidget extends StatelessWidget {
  final String iban;

  const DonateWidget({Key? key, required this.iban, required TextStyle style}) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('IBAN panoya kopyalandı')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _copyToClipboard(context, iban),
          child: Image.asset(
            'assets/donate.png',
            width: 35,
            height: 35,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _copyToClipboard(context, iban),
          child: Text(
            iban,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
            ),
          ),
        ),
      ],
    );
  }
}