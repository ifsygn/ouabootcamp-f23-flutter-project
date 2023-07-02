
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/service/firebase_auth_service.dart';
import 'login_viewmodel.dart';

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
bool isPasswordVisible = false;

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const BackgroundGradient(),
          const Positioned(
            top: 45.0,
            child: ImageWidget(
              imagePath: 'assets/paw_image.png',
              width: 95.0,
              height: 65.0,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: CardWidget(
                  child: LoginForm(),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 15.0,
            child: BottomButtons(),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();


  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'ÜYE GİRİŞİ',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          EmailTextField(controller: _emailController),
          const SizedBox(height: 8.0),
          PasswordTextField(controller: _passwordController),
          const ForgotPasswordButton(),
          ElevatedButton(
            onPressed: () {
              signInWithEmailAndPassaword(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCE8BF8)),
            child: Container(
              width: 170.0,
              height: 45.0,
              alignment: Alignment.center,
              child: const Text('Giriş Yap', style: TextStyle(fontSize: 20.0, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8.0),
          const OrDivider(),
          const SizedBox(height: 8.0),
          const GoogleSignInButton(),
        ],
      ),
    );
  }
}

Future<void> signInWithEmailAndPassaword(BuildContext context) async {
  try {
    await Auth().signInWithEmailAndPassaword(
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
