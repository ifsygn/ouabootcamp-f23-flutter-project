import 'package:flutter/material.dart';

import '../../view/authentification/auth_viewmodel.dart';
import '../../view/authentification/signup_view.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (password == confirmPassword) {
          createUserWithEmailAndPassword(context);
          Navigator.of(context).pop();
        }
        else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text('Şifre doğrulanamadı.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Tamam'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCE8BF8)),
      child: Container(
        width: 170.0,
        height: 45.0,
        alignment: Alignment.center,
        child: const Text('Üye Ol', style: TextStyle(fontSize: 20.0, color: Colors.white)),
      ),
    );
  }
} //common.widget.XXX.dart