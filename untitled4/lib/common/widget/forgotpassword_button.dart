import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/authentication/login_view.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // Şifremi unuttum işlemleri   (ARDAHAN)
          },
          child: TextButton(
            onPressed: () {
              forgotPassword(context);
            },
            child: const Text(
              'Şifremi unuttum?',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}