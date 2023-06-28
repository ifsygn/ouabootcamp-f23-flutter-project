import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../view/authentification/auth_viewmodel.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        signInWithEmailAndPassword(context);
      },
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCE8BF8)),
      child: Container(
        width: 170.0,
        height: 45.0,
        alignment: Alignment.center,
        child: const Text('Giriş Yap', style: TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
    );
  }
} //common.widget.XXX.dart