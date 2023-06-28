import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/service/firebase_auth_service.dart';

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

// GoogleSignInButton_View
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 45.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton.icon(
        onPressed: () {
          Auth().signInWithGoogle();
          // Google ile kaydol işlemleri    (ARDAHAN)
        },
        icon: Image.asset(
          'assets/google_logo.png',
          width: 35.0,
          height: 35.0,
        ),
        label: const Text(
          ' Google ile Giriş Yap ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//signin
Future<void> signInWithEmailAndPassword(BuildContext context) async {
  try {
    await Auth().signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }
  on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.message.toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> forgotPassword(BuildContext context) async{
  try {
    await Auth().verifyEmail(
      email: _emailController.text,
      password: _passwordController.text,
    );
    const snackBar = SnackBar(
      content: Text('Password Reset Email Sent !'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.message.toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

//signup
Future<void> createUserWithEmailAndPassword(BuildContext context) async {
  try {
    await Auth().createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }
  on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.message.toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}