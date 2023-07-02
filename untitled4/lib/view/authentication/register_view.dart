import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common/widget/background_gradient.dart';
import '../../common/widget/card_widget.dart';
import '../../common/widget/confirm_textfield.dart';
import '../../common/widget/email_textfield.dart';
import '../../common/widget/image_widget.dart';
import '../../common/widget/ordivider_text.dart';
import '../../core/service/firebase_auth_service.dart';


class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    appImage="assets/paw_image.png";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const BackgroundGradient(),
           Positioned(
            top: 45.0,
            child: ImageWidget(
              imagePath: appImage,
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
          Positioned(
            top: 25,
            left: 5,
            child: IconButton(
              padding: const EdgeInsets.all(18),
              alignment: Alignment.centerLeft,
              tooltip: 'Go back',
              enableFeedback: true,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

String confirmPassword = '';
String password = '';
String appImage='';

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

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
            'ÜYE OLMA GİRİŞİ',
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
          const SizedBox(height: 8.0),
          ConfirmTextField(confirmController: _confirmPasswordController),
          const SizedBox(height: 20.0),
          ElevatedButton(
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

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}
class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: ImageWidget(
            imagePath: 'assets/password_icon.png',
            width: 28.0,
            height: 28.0,
          ),
        ),
        Expanded(
          child: TextFormField(
            onChanged: (value ) {
              password = value;
            },
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1.0),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: !isPasswordVisible,
          ),
        ),
      ],
    );
  }
}

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
        },
        icon: Image.asset(
          'assets/google_logo.png',
          width: 35.0,
          height: 35.0,
        ),
        label: const Text(
          ' Google ile Üye Ol ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
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